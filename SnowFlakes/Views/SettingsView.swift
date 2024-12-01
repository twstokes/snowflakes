import SpriteKit
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettingsManager: AppSettingsManager
    @State var showingAdvanced = false
    weak var renderer: SnowRenderer?

    var appSettings: AppSettings { appSettingsManager.appSettings }

    var body: some View {
        VStack {
            SlidersView(
                size: $appSettingsManager.appSettings.size,
                birthRate: $appSettingsManager.appSettings.birthRate,
                mode: appSettingsManager.appSettings.mode,
                renderer: renderer
            )

            Divider()

            HStack {
                Toggle(appSettings.enabled ? "On" : "Off", isOn: $appSettingsManager.appSettings.enabled)
                    .toggleStyle(.switch)
                    .tint(Color.green)
                    .labelsHidden()
                    .onChange(of: appSettings.enabled) { renderer?.toggle(appSettings: appSettings) }
                Spacer()
                Button(action: { showingAdvanced.toggle()
                }, label: {
                    Image(systemName: showingAdvanced ? "gearshape.fill" : "gearshape")
                        .resizable()
                        .frame(width: 15, height: 15)
                })
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }.padding([.top], 5)

            if showingAdvanced {
                VStack(alignment: .leading, spacing: 10) {
                    Divider()
                    Group {
                        Text("Mode")
                            .bold()
                        Picker("", selection: $appSettingsManager.appSettings.mode) {
                            Text("Puffs")
                                .tag(EmitterMode.snow)
                            Text("Flakes")
                                .tag(EmitterMode.flakes)
                        }
                        .horizontalRadioGroupLayout()
                        .pickerStyle(.radioGroup)
                        .onChange(of: appSettings.mode) {
                            renderer?.changeToMode(appSettings.mode, size: appSettings.size, birthrate: appSettings.birthRate)
                        }
                    }

                    Group {
                        Text("Visibility")
                            .bold()

                        Toggle("Always on Top", isOn: $appSettingsManager.appSettings.alwaysOnTop)
                            .toggleStyle(.checkbox)
                            .onChange(of: appSettings.alwaysOnTop) { renderer?.toggle(appSettings: appSettings) }
                    }

                    Group {
                        Text("Performance")
                            .bold()

                        Slider(value: $appSettingsManager.appSettings.fps, in: 10 ... 60, step: 10) {
                            Text("\(Int(appSettings.fps)) FPS")
                                .onChange(of: appSettings.fps) { renderer?.changeFps($1) }
                        }
                    }
                }.padding([.top], 5)
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
