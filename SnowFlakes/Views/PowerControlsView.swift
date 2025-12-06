import SwiftUI

struct PowerControlsView: View {
    @Binding var enabled: Bool
    @Binding var showingAdvanced: Bool

    var body: some View {
        HStack {
            Toggle(enabled ? "On" : "Off", isOn: $enabled)
                .toggleStyle(.switch)
                .tint(Color.blue)
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

struct PowerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PowerControlsView(
            enabled: .constant(true),
            showingAdvanced: .constant(false)
        )
            .padding()
            .frame(width: 300)
    }
}
