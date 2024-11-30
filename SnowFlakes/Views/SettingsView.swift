import SwiftUI
import SpriteKit

struct SettingsView: View {
    @EnvironmentObject var appSettingsManager: AppSettingsManager
    @State var showingAdvanced = false
    weak var renderer: SnowRenderer?

    var appSettings: AppSettings { appSettingsManager.appSettings }

    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $appSettingsManager.appSettings.mode) {
                    Image("snow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .tag(EmitterMode.snow)
                    Image("flake")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 20)
                        .tag(EmitterMode.flakes)
                }
                .pickerStyle(.radioGroup)
                .onChange(of: appSettings.mode) {
                    renderer?.changeToMode(appSettings.mode, size: appSettings.size, birthrate: appSettings.birthRate)
                }
                Divider()
                    .frame(height: 70)
                VStack {

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
                }
            }
            Divider()
                .padding(.vertical, 5)

            HStack {
                Toggle(appSettings.enabled ? "On" : "Off", isOn: $appSettingsManager.appSettings.enabled)
                    .toggleStyle(.switch)
                    .tint(Color.green)
                    .labelsHidden()
                    .onChange(of: appSettings.enabled) { renderer?.toggle(appSettings: appSettings) }
                Spacer()
                Button(action: { showingAdvanced.toggle()
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 15, height: 15)
                })
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }

            if showingAdvanced {
                VStack (alignment: .leading) {
                    Slider(value: $appSettingsManager.appSettings.fps, in: 15...60, step: 5) {
                        Text("\(Int(appSettings.fps)) FPS")
                            .bold()
                            .onChange(of: appSettings.fps) { renderer?.changeFps($1) }
                    }
                    Toggle("Always on Top", isOn: $appSettingsManager.appSettings.alwaysOnTop)
                        .toggleStyle(.checkbox)
                        .onChange(of: appSettings.alwaysOnTop) { renderer?.toggle(appSettings: appSettings) }
                }
            }
        }
        .padding()
        .frame(width: 275)
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
            .previewDisplayName("Advanced Collapsed")
            .environmentObject(AppSettingsManager.shared)

        SettingsView(showingAdvanced: true)
            .previewDisplayName("Advanced Open")
            .environmentObject(AppSettingsManager.shared)
    }
}
