import Foundation

final class FlakeScene: BaseScene {
    override init(size: CGSize) {
        super.init(size: size)

        let emitter1 = FlakeEmitter()
        let emitter2 = FlakeEmitter()
        emitter2.particleRotationSpeed = -1
        
        addEmitters(emitters: [emitter1, emitter2])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
