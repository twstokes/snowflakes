import Foundation

final class AppSettings: ObservableObject {
    @Published var enabled: Bool
    @Published var runFrequency: RunFrequency
    @Published var fps: Float
    @Published var mode: EmitterMode
    @Published var birthRate: Float
    @Published var size: Float

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
