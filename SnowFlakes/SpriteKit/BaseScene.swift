import Foundation
import SpriteKit

class BaseScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)

        /// Place in the center of the screen at the top
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
    }

    /// Set's the emitter's position according to the scene's size
    /// Particles will span the width of the scene and start at the top
    private func setEmitterPosition(_ emitter: SKEmitterNode) {
        emitter.particlePositionRange.dx = size.width
        /// Note: When this is size.height it creates a neat "flurry" effect
        emitter.particlePositionRange.dy = 0
    }

    func addEmitters(emitters: [SKEmitterNode]) {
        for emitter in emitters {
            setEmitterPosition(emitter)
            addChild(emitter)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseScene {
    var emitters: [BaseEmitter] {
        children.compactMap { $0 as? BaseEmitter }
    }
}
