import SwiftData

@Model
final class AppSettings {
    @Attribute(.unique) var id = "snowflake-settings"

    var enabled: Bool
    var runFrequency: RunFrequency
    var fps: Float
    var mode: EmitterMode
    var birthRate: Float
    var size: Float

    init(
        enabled: Bool,
        runFrequency: RunFrequency,
        fps: Float,
        mode: EmitterMode,
        birthRate: Float,
        size: Float
    ) {
        self.enabled = enabled
        self.runFrequency = runFrequency
        self.fps = fps
        self.mode = mode
        self.birthRate = birthRate
        self.size = size
    }
}

extension AppSettings {
    static let defaults = AppSettings(
        enabled:        false,
        runFrequency:   .always,
        fps:            30,
        mode:           .snow,
        birthRate:      3.0,
        size:           3.0
    )
}
