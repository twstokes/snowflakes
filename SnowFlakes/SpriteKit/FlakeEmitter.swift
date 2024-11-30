import Foundation
import SpriteKit

final class FlakeEmitter: SKEmitterNode, BaseEmitter {
    override init() {
        super.init()

        guard let snowImage = NSImage(named: "flake") else {
            fatalError("Missing flake image asset!")
        }

        applyDefaults()
        particleTexture = SKTexture(image: snowImage)

        particleRotation = .pi
        particleRotationSpeed = 1
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
