import SpriteKit

extension OverlayWindow {
    /// Creates or reuses an SKView configured for overlays and installs it into the window.
    func configureSKView(frame: CGRect, preferredFPS: Int) -> SKView {
        if let existingView = skView {
            existingView.frame = frame
            existingView.preferredFramesPerSecond = preferredFPS
            return existingView
        }

        let view = SKView(frame: frame)
        view.preferredFramesPerSecond = preferredFPS
        view.allowsTransparency = true
        contentView = view
        return view
    }

    func present(scene: SKScene) {
        skView?.presentScene(scene)
    }
}
