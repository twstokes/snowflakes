import Foundation

final class EmitterScene: BaseScene {
    init(size: CGSize, mode: EmitterMode) {
        super.init(size: size)
        addEmitters(emitters: mode.emitters)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
