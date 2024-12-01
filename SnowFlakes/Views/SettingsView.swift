import SpriteKit
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettingsManager: AppSettingsManager
    @State var showingAdvanced = false
    weak var renderer: SnowRenderer?

    var body: some View {
        VStack {
            SlidersView(
                size: $appSettingsManager.appSettings.size,
                birthRate: $appSettingsManager.appSettings.birthRate,
                mode: appSettingsManager.appSettings.mode,
                renderer: renderer
            )

            Divider()

            PowerControlsView(
                enabled: $appSettingsManager.appSettings.enabled,
                appSettings: appSettingsManager.appSettings,
                showingAdvanced: $showingAdvanced,
                renderer: renderer
            )

            if showingAdvanced {
                AdvancedSettingsView(
                    mode: $appSettingsManager.appSettings.mode,
                    alwaysOnTop: $appSettingsManager.appSettings.alwaysOnTop,
                    fps: $appSettingsManager.appSettings.fps,
                    appSettings: appSettingsManager.appSettings,
                    size: appSettingsManager.appSettings.size,
                    birthRate: appSettingsManager.appSettings.birthRate,
                    renderer: renderer
                )
            }
        }
        .padding()
        .frame(width: 220)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewDisplayName("Advanced Collapsed")
            .environmentObject(AppSettingsManager.shared)

        SettingsView(showingAdvanced: true)
            .previewDisplayName("Advanced Open")
            .environmentObject(AppSettingsManager.shared)
    }
}
