import SwiftUI

struct PowerControlsView: View {
    @Binding var enabled: Bool
    @Binding var showingAdvanced: Bool

    var body: some View {
        HStack {
            Toggle(enabled ? "On" : "Off", isOn: $enabled)
                .toggleStyle(.switch)
                .tint(Color.green)
                .labelsHidden()
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
