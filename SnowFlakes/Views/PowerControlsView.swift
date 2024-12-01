//
//  PowerControlsView.swift
//  SnowFlakes
//
//  Created by Tanner W. Stokes on 12/1/24.
//
import SwiftUI

struct PowerControlsView: View {
    @Binding var enabled: Bool
    let appSettings: AppSettings
    @Binding var showingAdvanced: Bool
    var renderer: SnowRenderer?

    var body: some View {
        HStack {
            Toggle(enabled ? "On" : "Off", isOn: $enabled)
                .toggleStyle(.switch)
                .tint(Color.green)
                .labelsHidden()
                .onChange(of: enabled) { renderer?.toggle(appSettings: appSettings) }
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
    }
}
