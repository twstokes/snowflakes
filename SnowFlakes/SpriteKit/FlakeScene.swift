import Foundation

extension EmitterMode {
    var emitters: [BaseEmitter] {
        switch self {
        case .snow:
            return [SnowEmitter()]
        case .flakes:
            let emitterClockwise = FlakeEmitter()
            let emitterCounterClockwise = FlakeEmitter()
            emitterCounterClockwise.particleRotationSpeed = -1
            return [emitterClockwise, emitterCounterClockwise]
        }
    }
}
