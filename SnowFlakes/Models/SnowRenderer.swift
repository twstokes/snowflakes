import AppKit
import Combine
import Foundation
import SpriteKit

final class SnowRenderer {
    private var cancellables = Set<AnyCancellable>()
    private weak var appSettings: AppSettings?

    private var overlayWindows: [OverlayWindow] {
        NSApp.overlayWindows
    }

    private var activeSKViews: [SKView] {
        overlayWindows
            .compactMap { $0.skView }
    }

    private var activeScenes: [BaseScene] {
        activeSKViews
            .compactMap { $0.scene as? BaseScene }
    }

    private var activeEmitters: [BaseEmitter] {
        activeScenes.flatMap { $0.emitters }
    }

    func observe(_ appSettings: AppSettings) {
        cancellables.removeAll()

        appSettings.$size
            .receive(on: RunLoop.main)
            .sink(receiveValue: changeSize)
            .store(in: &cancellables)

        appSettings.$birthRate
            .receive(on: RunLoop.main)
            .sink(receiveValue: changeBirthRate)
            .store(in: &cancellables)

        appSettings.$enabled
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.reload() }
            .store(in: &cancellables)

        appSettings.$mode
            .receive(on: RunLoop.main)
            .sink { [weak self] mode in
                self?.changeToMode(mode, size: appSettings.size, birthRate: appSettings.birthRate)
            }
            .store(in: &cancellables)

        appSettings.$fps
            .receive(on: RunLoop.main)
            .sink(receiveValue: changeFps)
            .store(in: &cancellables)

        appSettings.$alwaysOnTop
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.reload() }
            .store(in: &cancellables)

        self.appSettings = appSettings
    }

    func reload() {
        /// State shouldn't get out of sync, but just in case.
        destroyWindows()

        guard let appSettings, appSettings.enabled else {
            return
        }

        for screen in NSScreen.screens {
            let window = OverlayWindow(screen: screen, stayOnTop: appSettings.alwaysOnTop)
            let skView = window.configureSKView(frame: screen.frame, preferredFPS: Int(appSettings.fps))

            let scene = EmitterScene(size: screen.frame.size, mode: appSettings.mode)
            for emitter in scene.emitters {
                emitter.particleScale = CGFloat(appSettings.size / 10)
                emitter.particleBirthRate = CGFloat(appSettings.birthRate)
            }

            skView.presentScene(scene)
            window.orderFrontRegardless()
        }
    }

    private func destroyWindows() {
        overlayWindows.forEach { $0.close() }
    }

    func changeToMode(_ mode: EmitterMode, size: Float, birthRate: Float) {
        for activeSKView in activeSKViews {
            let scene = EmitterScene(size: activeSKView.frame.size, mode: mode)
            for emitter in scene.emitters {
                emitter.particleScale = CGFloat(size / 10)
                emitter.particleBirthRate = CGFloat(birthRate)
            }
            activeSKView.presentScene(scene)
        }
    }

    func changeSize(_ size: Float) {
        activeEmitters.forEach { $0.particleScale = CGFloat(size / 10) }
    }

    func changeBirthRate(_ birthRate: Float) {
        activeEmitters.forEach { $0.particleBirthRate = CGFloat(birthRate) }
    }

    func changeFps(_ fps: Float) {
        activeSKViews.forEach { $0.preferredFramesPerSecond = Int(fps) }
    }
}
