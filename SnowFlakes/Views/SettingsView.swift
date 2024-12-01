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
                mode: appSettingsManager.appSettings.mode
            )
            .onChange(of: appSettingsManager.appSettings.size) { renderer?.changeSize($1) }
            .onChange(of: appSettingsManager.appSettings.birthRate) { renderer?.changeBirthRate($1) }

            Divider()

            PowerControlsView(
                enabled: $appSettingsManager.appSettings.enabled,
                showingAdvanced: $showingAdvanced
            )
            .onChange(of: appSettingsManager.appSettings.enabled) {
                renderer?.toggle(appSettings: appSettingsManager.appSettings)
            }

            if showingAdvanced {
                AdvancedSettingsView(
                    mode: $appSettingsManager.appSettings.mode,
                    alwaysOnTop: $appSettingsManager.appSettings.alwaysOnTop,
                    fps: $appSettingsManager.appSettings.fps
                )
                .onChange(of: appSettingsManager.appSettings.mode) {
                    renderer?.changeToMode(
                        appSettingsManager.appSettings.mode,
                        size: appSettingsManager.appSettings.size,
                        birthRate: appSettingsManager.appSettings.birthRate
                    )
                }
                .onChange(of: appSettingsManager.appSettings.alwaysOnTop) {
                    renderer?.toggle(appSettings: appSettingsManager.appSettings)
                }
                .onChange(of: appSettingsManager.appSettings.fps) {
                    renderer?.changeFps($1)
                }
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
