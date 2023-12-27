import Foundation

final class SnowScene: BaseScene {
    override init(size: CGSize) {
        super.init(size: size)

        let emitter1 = SnowEmitter()
        addEmitters(emitters: [emitter1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
