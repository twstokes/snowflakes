import Combine
import SwiftData

@MainActor
class AppSettingsManager: ObservableObject {
    static let shared = AppSettingsManager()

    @Published var appSettings: AppSettings
    private let container: ModelContainer

    private init() {
        do {
            container = try ModelContainer(for: AppSettings.self)

            if let existingAppSettings = try container.mainContext.fetch(FetchDescriptor<AppSettings>()).first {
                appSettings = existingAppSettings
            } else {
                let newSettings = AppSettings.defaults
                container.mainContext.insert(newSettings)
                appSettings = newSettings
                try container.mainContext.save()
            }
        } catch {
            fatalError("Failed to initialize SwiftData container: \(error)")
        }
    }
}
