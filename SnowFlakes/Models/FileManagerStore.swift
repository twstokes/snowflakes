//
//  FileManagerStore.swift
//  SnowFlakes
//
//  Created by Tanner W. Stokes on 12/1/24.
//
import Combine
import Foundation

final class FileManagerStore: SettingsStore {
    private var cancellable: AnyCancellable?

    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("settings.json")

    func loadAppSettings() -> AppSettings {
        do {
            let savedData = try Data(contentsOf: filePath)
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
            .sink { [weak self] in self?.saveAppSettings(appSettings: appSettings) }
    }

    private func saveAppSettings(appSettings: AppSettings) {
        do {
            let encoded = try JSONEncoder().encode(appSettings)
            try encoded.write(to: filePath)
        } catch {
            print("Encoding error! \(error.localizedDescription)")
        }
    }
}
