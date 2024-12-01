import Foundation

final class AppSettings {
    var enabled: Bool
    var runFrequency: RunFrequency
    var fps: Float
    var mode: EmitterMode
    var birthRate: Float
    var size: Float
    var alwaysOnTop: Bool

    init(
        enabled: Bool,
        runFrequency: RunFrequency,
        fps: Float,
        mode: EmitterMode,
        birthRate: Float,
        size: Float,
        alwaysOnTop: Bool
    ) {
        self.enabled = enabled
        self.runFrequency = runFrequency
        self.fps = fps
        self.mode = mode
        self.birthRate = birthRate
        self.size = size
        self.alwaysOnTop = alwaysOnTop
    }
}

extension AppSettings {
    static let defaults = AppSettings(
        enabled: false,
        runFrequency: .always,
        fps: 30,
        mode: .snow,
        birthRate: 3.0,
        size: 3.0,
        alwaysOnTop: false
    )
}
