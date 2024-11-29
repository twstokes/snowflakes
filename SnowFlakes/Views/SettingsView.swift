import SwiftUI
import SpriteKit

struct SettingsView: View {
    @EnvironmentObject var appSettingsManager: AppSettingsManager
    @State var showingAdvanced = false
    weak var renderer: SnowRenderer?

    var appSettings: AppSettings { appSettingsManager.appSettings }

    var body: some View {
        VStack {
            Picker("", selection: $appSettingsManager.appSettings.mode) {
                Text("Puffs").tag(EmitterMode.snow)
                Text("Flakes").tag(EmitterMode.flakes)
            }
            .pickerStyle(.segmented)
            .onChange(of: appSettings.mode) {
                renderer?.changeToMode(appSettings.mode, size: appSettings.size, birthrate: appSettings.birthRate)
            }

            HStack {
                sizeImageForMode
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.5)
                    .frame(width: 25, height: 20)
                Slider(value: $appSettingsManager.appSettings.size, in: 1...5, step: 1)
                    .onChange(of: appSettings.size) { renderer?.changeSize($1) }
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
                    .onChange(of: appSettings.birthRate) { renderer?.changeBirthRate($1) }
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
                Toggle(appSettings.enabled ? "On" : "Off", isOn: $appSettingsManager.appSettings.enabled)
                    .toggleStyle(PowerToggleStyle())
                    .onChange(of: appSettings.enabled) { renderer?.toggle(appSettings: appSettings) }
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }

            if showingAdvanced {
                Slider(value: $appSettingsManager.appSettings.fps, in: 15...60, step: 5) {
                    Text("\(Int(appSettings.fps)) FPS")
                        .bold()
                        .onChange(of: appSettings.fps) { renderer?.changeFps($1) }
                }
            }
        }
        .padding()
    }

    private var sizeImageForMode: Image {
        switch appSettings.mode {
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
