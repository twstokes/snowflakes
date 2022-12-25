import Foundation

final class AppSettings: ObservableObject {
    @Published var enabled: Bool
    @Published var runFrequency: RunFrequency
    @Published var fps: Float
    @Published var mode: EmitterMode
    @Published var birthrate: Float
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
        self.birthrate = birthrate
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

extension AppSettings: Codable {
    private enum CodingKeys: CodingKey {
        case enabled
        case runFrequency
        case fps
        case mode
        case birthrate
        case size
    }

    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let enabled =       try values.decodeIfPresent(Bool.self,           forKey: .enabled)
        let runFrequency =  try values.decodeIfPresent(RunFrequency.self,   forKey: .runFrequency)
        let fps =           try values.decodeIfPresent(Float.self,          forKey: .fps)
        let mode =          try values.decodeIfPresent(EmitterMode.self,    forKey: .mode)
        let birthrate =     try values.decodeIfPresent(Float.self,          forKey: .birthrate)
        let size =          try values.decodeIfPresent(Float.self,          forKey: .size)

        self.init(
            enabled:        enabled ??      Self.defaults.enabled,
            runFrequency:   runFrequency ?? Self.defaults.runFrequency,
            fps:            fps ??          Self.defaults.fps,
            mode:           mode ??         Self.defaults.mode,
            birthrate:      birthrate ??    Self.defaults.birthrate,
            size:           size ??         Self.defaults.size
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(enabled, forKey: .enabled)
        try container.encode(runFrequency, forKey: .runFrequency)
        try container.encode(fps, forKey: .fps)
        try container.encode(mode, forKey: .mode)
        try container.encode(birthrate, forKey: .birthrate)
        try container.encode(size, forKey: .size)
    }
}
