import SwiftData
import SwiftUI
import SpriteKit


struct SettingsView: View {
    @EnvironmentObject var appSettingsManager: AppSettingsManager
    @State var showingAdvanced = false
    weak var renderer: SnowRenderer?

    var body: some View {
        VStack {
            Picker("", selection: $appSettingsManager.appSettings.mode) {
                Text("Puffs").tag(EmitterMode.snow)
                Text("Flakes").tag(EmitterMode.flakes)
            }
            .pickerStyle(.segmented)
            .onChange(of: appSettingsManager.appSettings.mode) {
                renderer?.changeToMode(appSettingsManager.appSettings.mode, size: appSettingsManager.appSettings.size, birthrate: appSettingsManager.appSettings.birthRate)
            }

            HStack {
                sizeImageForMode
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.5)
                    .frame(width: 25, height: 20)
                Slider(value: $appSettingsManager.appSettings.size, in: 1...5, step: 1)
                    .onChange(of: appSettingsManager.appSettings.size) {
                        renderer?.changeSize(appSettingsManager.appSettings.size)
                    }
                sizeImageForMode
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 20)
            }

            Divider()
            HStack {
                Image("sparse")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 20)
                Slider(value: $appSettingsManager.appSettings.birthRate, in: 1...5, step: 1)
                    .onChange(of: appSettingsManager.appSettings.birthRate) {
                        renderer?.changeBirthrate(appSettingsManager.appSettings.birthRate)
                    }
                Image("dense")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 20)
            }
            Divider()

            HStack {
                Button(action: { showingAdvanced.toggle()
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 15, height: 15)
                })
                Spacer()
                Toggle(appSettingsManager.appSettings.enabled ? "On" : "Off", isOn: $appSettingsManager.appSettings.enabled)
                    .toggleStyle(PowerToggleStyle())
                    .onChange(of: appSettingsManager.appSettings.enabled) {
                        appSettingsManager.appSettings.enabled ? renderer?.start(appSettings: appSettingsManager.appSettings) : renderer?.stop()
                    }
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }

            if showingAdvanced {
                Slider(value: $appSettingsManager.appSettings.fps, in: 15...60, step: 5) {
                    Text("\(Int(appSettingsManager.appSettings.fps)) FPS")
                        .bold()
                        .onChange(of: appSettingsManager.appSettings.fps) {
                            renderer?.changeFps(appSettingsManager.appSettings.fps)
                        }
                }
            }
        }
        .padding()
    }

    private var sizeImageForMode: Image {
        switch appSettingsManager.appSettings.mode {
        case .snow:
            return Image("snow")
        case .flakes:
            return Image("flake")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .frame(width: 300)
            .previewDisplayName("Advanced Collapsed")

        SettingsView(showingAdvanced: true)
            .frame(width: 300)
            .previewDisplayName("Advanced Open")
    }
}
