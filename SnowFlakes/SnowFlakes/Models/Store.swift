import Foundation

protocol SettingsStore {
    func saveAppState(_ state: AppState) throws
    func loadAppState() -> AppState?
}

struct UserDefaultsStore: SettingsStore {
    private static let appStateKey = "app_state"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func saveAppState(_ state: AppState) throws {
        let encoder = JSONEncoder()

        do {
            let encoded = try encoder.encode(state)
            let string = String(data: encoded, encoding: .utf8)
            userDefaults.set(string, forKey: Self.appStateKey)
        }
    }

    func loadAppState() -> AppState? {
        let decoder = JSONDecoder()

        guard
            let encoded = userDefaults.object(forKey: Self.appStateKey) as? String,
            let data = encoded.data(using: .utf8),
            let decoded = try? decoder.decode(AppState.self, from: data)
        else {
            return nil
        }

        return decoded
    }
}
