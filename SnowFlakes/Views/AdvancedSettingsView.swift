import AppKit
import SwiftUI

struct AdvancedSettingsView: View {
    @Binding var mode: EmitterMode
    @Binding var alwaysOnTop: Bool
    @Binding var fps: Float
    @Binding var size: Float
    @Binding var birthRate: Float
    let settingsFileURL: URL

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SlidersView(
                size: $size,
                birthRate: $birthRate,
                mode: mode
            )
            Divider()
            Group {
                Text("Mode")
                    .bold()
                Picker("", selection: $mode) {
                    Text("Puffs")
                        .tag(EmitterMode.snow)
                    Text("Flakes")
                        .tag(EmitterMode.flakes)
                }
                .horizontalRadioGroupLayout()
                .pickerStyle(.radioGroup)
            }
            Group {
                Text("Visibility")
                    .bold()
                Toggle("Always on Top", isOn: $alwaysOnTop)
                    .toggleStyle(.checkbox)
            }
            Group {
                Text("Performance")
                    .bold()
                Slider(value: $fps, in: 10 ... 60, step: 10) {
                    Text("\(Int(fps)) FPS")
                }
            }
            Group {
                Text("Persistence")
                    .bold()
                Button("Open Settings File Location") {
                    revealSettingsFile()
                }
            }
        }.padding([.top], 5)
    }

    private func revealSettingsFile() {
        let targetURL: URL
        if FileManager.default.fileExists(atPath: settingsFileURL.path) {
            targetURL = settingsFileURL
        } else {
            targetURL = settingsFileURL.deletingLastPathComponent()
        }

        NSWorkspace.shared.activateFileViewerSelecting([targetURL])
    }
}
