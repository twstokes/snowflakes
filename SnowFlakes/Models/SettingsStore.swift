import Foundation
import Combine

protocol SettingsStore {
    func loadAppState() throws -> AppSettings?
    /// Observes changes to AppState and commits them automatically.
    func observe(_ appState: AppSettings)
}

final class UserDefaultsStore: SettingsStore {
    typealias SavedCallback = (Result<AppSettings, Error>) -> Void

    private static let storeKey = "state_store"
    private let userDefaults: UserDefaults
    private var cancellable: AnyCancellable?

    /// Optional callback to be notified when a save operation has completed.
    private var savedCallback: SavedCallback?

    init(
        userDefaults: UserDefaults = UserDefaults.standard,
        savedCallback: SavedCallback? = nil
    ) {
        self.userDefaults = userDefaults
        self.savedCallback = savedCallback
    }

    func loadAppState() throws -> AppSettings? {
        guard let data = userDefaults.object(forKey: Self.storeKey) as? Data else {
            return nil
        }

        let decoder = JSONDecoder()
        return try decoder.decode(AppSettings.self, from: data)
    }

    /// Observe the supplied AppState and save it to UserDefaults when there are changes.
    func observe(_ appState: AppSettings) {
        cancellable = appState.objectWillChange
            .receive(on: RunLoop.main) /// this is required to get the latest value
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] in self?.saveAppState(appState: appState) }
    }

    private func saveAppState(appState: AppSettings) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(appState)
            userDefaults.set(encoded, forKey: Self.storeKey)
            savedCallback?(.success(appState))
        } catch {
            savedCallback?(.failure(error))
        }
    }
}
