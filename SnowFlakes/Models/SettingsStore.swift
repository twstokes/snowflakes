import Foundation

protocol SettingsStore {
    func loadAppSettings() -> AppSettings
    /// Observes changes to AppSettings and commits them automatically.
    func observe(_ appSettings: AppSettings)
}
