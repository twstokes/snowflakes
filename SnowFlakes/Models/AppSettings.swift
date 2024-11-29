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
        birthrate: Float,
        size: Float
    ) {
        self.enabled = enabled
        self.runFrequency = runFrequency
        self.fps = fps
        self.mode = mode
        self.birthRate = birthrate
        self.size = size
    }
}

extension AppSettings {
    static let defaults = AppSettings(
        enabled:        false,
        runFrequency:   .always,
        fps:            30,
        mode:           .snow,
        birthrate:      3.0,
        size:           3.0
    )
}
