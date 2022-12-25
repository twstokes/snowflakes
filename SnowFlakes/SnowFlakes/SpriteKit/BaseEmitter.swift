import Foundation
import SpriteKit

protocol BaseEmitter: SKEmitterNode {
    func applyDefaults()
}

extension BaseEmitter {
    func applyDefaults() {
        particleAlphaRange = 0.2

        particleBirthRate = 3

        /// Note - we may need to be clever here because higher vertical resolutions probably need a higher lifetime
        particleLifetime = 10

        emissionAngle = 270
        emissionAngleRange = 22

        particleSpeed = 80
        particleSpeedRange = 100

        xAcceleration = 0
        yAcceleration = -10

        particleScale = 0.2
        particleScaleRange = 0.2
        particleScaleSpeed = 0

        particleColor = .white
        particleColorBlendFactor = 1
    }
}
