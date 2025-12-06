import Combine
import Foundation

final class FileManagerStore: SettingsStore {
    private var cancellable: AnyCancellable?
    private let fileURL: URL

    var settingsFileURL: URL {
        fileURL
    }

    init(
        fileManager: FileManager = .default,
        bundle: Bundle = .main,
        applicationSupportDirectory: URL? = nil
    ) {
        let appSupportDirectory = applicationSupportDirectory ?? fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let bundleIdentifier = bundle.bundleIdentifier ?? ProcessInfo.processInfo.processName
        let settingsDirectory = appSupportDirectory.appendingPathComponent(bundleIdentifier, isDirectory: true)

        do {
            try fileManager.createDirectory(at: settingsDirectory, withIntermediateDirectories: true)
        } catch {
            print("Unable to create Application Support directory: \(error.localizedDescription)")
        }

        if fileManager.fileExists(atPath: settingsDirectory.path) {
            fileURL = settingsDirectory.appendingPathComponent("settings.json")
        } else {
            // If the bundle-specific folder could not be created, fall back to the base Application Support directory.
            fileURL = appSupportDirectory.appendingPathComponent("settings.json")
        }
    }

    func loadAppSettings() -> AppSettings {
        do {
            let savedData = try Data(contentsOf: fileURL)
            let loadedSettings = try JSONDecoder().decode(AppSettings.self, from: savedData)
            return loadedSettings
        } catch {
            return AppSettings.defaults
        }
    }

    /// Observe the supplied AppSettings and save them if there are changes.
    func observe(_ appSettings: AppSettings) {
        cancellable = appSettings.objectWillChange
            .receive(on: RunLoop.main) /// this is required to get the latest value
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] in self?.saveAppSettings(appSettings) }
    }

    private func saveAppSettings(_ appSettings: AppSettings) {
        do {
            let encoded = try JSONEncoder().encode(appSettings)
            try encoded.write(to: fileURL, options: [.atomic])
        } catch {
            print("Encoding error! \(error.localizedDescription)")
        }
    }
}
