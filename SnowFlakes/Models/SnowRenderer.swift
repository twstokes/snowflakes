import AppKit
import Foundation
import SpriteKit

final class SnowRenderer {
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

    // TODO: - extract render settings from AppSettings to that the entire app settings aren't passed around (leakage)
    func toggle(appSettings: AppSettings) {
        /// State shouldn't get out of sync, but just in case.
        destroyWindows()

        guard appSettings.enabled else {
            return
        }

        for screen in NSScreen.screens {
            let window = OverlayWindow(screen: screen, stayOnTop: appSettings.alwaysOnTop)

            let view = SKView(frame: screen.frame)
            view.preferredFramesPerSecond = Int(appSettings.fps)
            view.allowsTransparency = true

            let scene = appSettings.mode.scene(size: screen.frame.size)
            for emitter in scene.emitters {
                emitter.particleScale = CGFloat(appSettings.size / 10)
                emitter.particleBirthRate = CGFloat(appSettings.birthRate)
            }

            view.presentScene(scene)
            window.contentView = view
            window.orderFrontRegardless()
        }
    }

    private func destroyWindows() {
        overlayWindows.forEach { $0.close() }
    }

    func changeToMode(_ mode: EmitterMode, size: Float, birthrate: Float) {
        for activeSKView in activeSKViews {
            let scene = mode.scene(size: activeSKView.frame.size)
            for emitter in scene.emitters {
                emitter.particleScale = CGFloat(size / 10)
                emitter.particleBirthRate = CGFloat(birthrate)
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

//    private func changeRunFrequency(frequency: RunFrequency) {
//        print("TODO: update run frequency") /// OR handle somewhere else like the AppState
//    }
}

private extension EmitterMode {
    func scene(size: CGSize) -> BaseScene {
        switch self {
        case .snow:
            return SnowScene(size: size)
        case .flakes:
            return FlakeScene(size: size)
        }
    }
}
