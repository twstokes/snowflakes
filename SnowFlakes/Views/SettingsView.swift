import SpriteKit
import SwiftUI

struct SettingsView: View {
    @ObservedObject var appSettings: AppSettings
    let settingsFileURL: URL
    @State var showingAdvanced = false

    var body: some View {
        VStack {
            SlidersView(
                size: $appSettings.size,
                birthRate: $appSettings.birthRate,
                mode: appSettings.mode
            )

            Divider()

            PowerControlsView(
                enabled: $appSettings.enabled,
                showingAdvanced: $showingAdvanced
            )

            if showingAdvanced {
                AdvancedSettingsView(
                    mode: $appSettings.mode,
                    alwaysOnTop: $appSettings.alwaysOnTop,
                    fps: $appSettings.fps,
                    settingsFileURL: settingsFileURL
                )
            }
        }
        .padding()
        .frame(width: 220)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previewSettingsURL = FileManager.default
        .temporaryDirectory
        .appendingPathComponent("settings.json")

    static var previews: some View {
        SettingsView(appSettings: AppSettings.defaults, settingsFileURL: previewSettingsURL)
            .previewDisplayName("Advanced Collapsed")

        SettingsView(
            appSettings: AppSettings.defaults,
            settingsFileURL: previewSettingsURL,
            showingAdvanced: true
        )
            .previewDisplayName("Advanced Open")
    }
}
