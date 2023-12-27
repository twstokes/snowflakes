import Foundation
import AppKit
import SpriteKit
import Combine

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

        self.appSettings = appSettings

        appSettings.$size
            .receive(on: RunLoop.main)
            .sink(receiveValue: changeSize)
            .store(in: &cancellables)

        appSettings.$birthRate
            .receive(on: RunLoop.main)
            .sink(receiveValue: changeBirthrate)
            .store(in: &cancellables)

        appSettings.$enabled
            .receive(on: RunLoop.main)
            .sink { [weak self] enabled in
                enabled ? self?.start() : self?.stop()
            }
            .store(in: &cancellables)

        appSettings.$mode
            .receive(on: RunLoop.main)
            .sink { [weak self] mode in
                self?.changeToMode(mode, size: appSettings.size, birthrate: appSettings.birthRate) // NOTE: cleanup, isolate mode?
            }
            .store(in: &cancellables)

        appSettings.$fps
            .receive(on: RunLoop.main)
            .sink(receiveValue: changeFps)
            .store(in: &cancellables)
    }

    private func start() {
        guard let appSettings else { return }
        /// State shouldn't get out of sync, but just in case.
        destroyWindows()

        for screen in NSScreen.screens {
            let window = OverlayWindow(screen: screen)

            let view = SKView(frame: screen.frame)
            view.preferredFramesPerSecond = Int(appSettings.fps)
            view.allowsTransparency = true

            let scene = appSettings.mode.scene(size: screen.frame.size)
            scene.emitters.forEach {
                $0.particleScale = CGFloat(appSettings.size / 10)
                $0.particleBirthRate = CGFloat(appSettings.birthRate)
            }

            view.presentScene(scene)
            window.contentView = view
            window.orderFrontRegardless()
        }
    }

    private func stop() {
        destroyWindows()
    }

    private func destroyWindows(){
        overlayWindows.forEach { $0.close() }
    }

    private func changeToMode(_ mode: EmitterMode, size: Float, birthrate: Float) {
        activeSKViews.forEach {
            let scene = mode.scene(size: $0.frame.size)
            scene.emitters.forEach {
                $0.particleScale = CGFloat(size / 10)
                $0.particleBirthRate = CGFloat(birthrate)
            }
            $0.presentScene(scene)
        }
    }

    private func changeSize(_ size: Float) {
        activeEmitters.forEach { $0.particleScale = CGFloat(size / 10) }
    }

    private func changeBirthrate(_ birthrate: Float) {
        activeEmitters.forEach { $0.particleBirthRate = CGFloat(birthrate) }
    }

    private func changeFps(_ fps: Float) {
        activeSKViews.forEach { $0.preferredFramesPerSecond = Int(fps) }
    }

//    private func changeRunFrequency(frequency: RunFrequency) {
//        print("TODO: update run frequency") /// OR handle somewhere else like the AppState
//    }
}

fileprivate extension EmitterMode {
    func scene(size: CGSize) -> BaseScene {
        switch self {
        case .snow:
            return SnowScene(size: size)
        case .flakes:
            return FlakeScene(size: size)
        }
    }
}
