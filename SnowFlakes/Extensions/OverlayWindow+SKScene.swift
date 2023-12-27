import Foundation
import SpriteKit

extension OverlayWindow {
    var skView: SKView? {
        return (contentView as? SKView)
    }
}
