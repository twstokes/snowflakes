import SwiftUI
import SpriteKit


struct SettingsView: View {
    @ObservedObject var appSettings: AppSettings
    @State var showingAdvanced = false


    var body: some View {
        VStack {
            Picker("", selection: $appSettings.mode) {
                Text("Puffs").tag(EmitterMode.snow)
                Text("Flakes").tag(EmitterMode.flakes)
            }.pickerStyle(.segmented)

            HStack {
                sizeImageForMode
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.5)
                    .frame(width: 25, height: 20)
                Slider(value: $appSettings.size, in: 1...5, step: 1)
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
                Slider(value: $appSettings.birthrate, in: 1...5, step: 1)
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
                Toggle(appSettings.enabled ? "On" : "Off", isOn: $appSettings.enabled)
                    .toggleStyle(PowerToggleStyle())
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }

            if showingAdvanced {
                Slider(value: $appSettings.fps, in: 15...60, step: 15) {
                    Text("CPU")
                        .bold()
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
        SettingsView(appSettings: AppSettings.defaults)
            .frame(width: 300)
            .previewDisplayName("Advanced Collapsed")

        SettingsView(appSettings: AppSettings.defaults, showingAdvanced: true)
            .frame(width: 300)
            .previewDisplayName("Advanced Open")
    }
}
