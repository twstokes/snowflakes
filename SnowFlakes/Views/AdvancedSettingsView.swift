//
//  AdvancedSettingsView.swift
//  SnowFlakes
//
//  Created by Tanner W. Stokes on 12/1/24.
//
import SwiftUI

struct AdvancedSettingsView: View {
    @Binding var mode: EmitterMode
    @Binding var alwaysOnTop: Bool
    @Binding var fps: Float

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
        }.padding([.top], 5)
    }
}
