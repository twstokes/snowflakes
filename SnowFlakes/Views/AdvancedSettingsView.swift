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
    let appSettings: AppSettings
    let size: Float
    let birthRate: Float
    var renderer: SnowRenderer?

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
                .onChange(of: mode) {
                    renderer?.changeToMode(mode, size: size, birthRate: birthRate)
                }
            }
            
            Group {
                Text("Visibility")
                    .bold()
                
                Toggle("Always on Top", isOn: $alwaysOnTop)
                    .toggleStyle(.checkbox)
                    .onChange(of: appSettings.alwaysOnTop) { renderer?.toggle(appSettings: appSettings) }
            }
            
            Group {
                Text("Performance")
                    .bold()
                
                Slider(value: $fps, in: 10 ... 60, step: 10) {
                    Text("\(Int(fps)) FPS")
                        .onChange(of: fps) { renderer?.changeFps($1) }
                }
            }
        }.padding([.top], 5)
    }
}
