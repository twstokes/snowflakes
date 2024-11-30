import Foundation

final class SnowScene: BaseScene {
    override init(size: CGSize) {
        super.init(size: size)

        let emitter1 = SnowEmitter()
        addEmitters(emitters: [emitter1])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
