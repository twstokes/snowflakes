import Foundation

final class AppSettings: ObservableObject {
    @Published var enabled: Bool
    @Published var fps: Float
    @Published var mode: EmitterMode
    @Published var birthRate: Float
    @Published var size: Float
    @Published var alwaysOnTop: Bool

    init(
        enabled: Bool,
        fps: Float,
        mode: EmitterMode,
        birthRate: Float,
        size: Float,
        alwaysOnTop: Bool
    ) {
        self.enabled = enabled
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
        fps: 30,
        mode: .snow,
        birthRate: 3.0,
        size: 3.0,
        alwaysOnTop: false
    )
}

extension AppSettings: Codable {
    private enum CodingKeys: CodingKey {
        case enabled
        case fps
        case mode
        case birthRate
        case size
        case alwaysOnTop
    }

    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        let fps = try values.decodeIfPresent(Float.self, forKey: .fps)
        let mode = try values.decodeIfPresent(EmitterMode.self, forKey: .mode)
        let birthRate = try values.decodeIfPresent(Float.self, forKey: .birthRate)
        let size = try values.decodeIfPresent(Float.self, forKey: .size)
        let alwaysOnTop = try values.decodeIfPresent(Bool.self, forKey: .alwaysOnTop)

        self.init(
            enabled: enabled ?? Self.defaults.enabled,
            fps: fps ?? Self.defaults.fps,
            mode: mode ?? Self.defaults.mode,
            birthRate: birthRate ?? Self.defaults.birthRate,
            size: size ?? Self.defaults.size,
            alwaysOnTop: alwaysOnTop ?? Self.defaults.alwaysOnTop
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(enabled, forKey: .enabled)
        try container.encode(fps, forKey: .fps)
        try container.encode(mode, forKey: .mode)
        try container.encode(birthRate, forKey: .birthRate)
        try container.encode(size, forKey: .size)
        try container.encode(alwaysOnTop, forKey: .alwaysOnTop)
    }
}
