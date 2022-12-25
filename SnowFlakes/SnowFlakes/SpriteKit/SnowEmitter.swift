import Foundation
import SpriteKit

final class SnowEmitter: SKEmitterNode, BaseEmitter {
    override init() {
        super.init()
        
        guard let snowImage = NSImage(named: "snow") else {
            fatalError("Missing snow image asset!")
        }

        applyDefaults()
        particleTexture = SKTexture(image: snowImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
