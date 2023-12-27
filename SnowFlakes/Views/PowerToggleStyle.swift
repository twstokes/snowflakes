import Foundation
import SwiftUI

/// This is more complex than necessary mainly due to putting a white circle behind the template image
/// for better visibility on certain backgrounds, and animations.
struct PowerToggleStyle: ToggleStyle {
    @State var color: Color = .clear

    private let activeColor = Color.accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()

            withAnimation(.easeInOut) {
                color = configuration.isOn ? activeColor : .secondary
            }
        } label: {
            Label {
            } icon: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .scaleEffect(0.9) // scale down slightly so it's not seen
                        .opacity(configuration.isOn ? 1 : 0)
                    
                    Image(configuration.isOn ? "Power On" : "Power Off")
                        .resizable()
                        .foregroundColor(.white)
                        .colorMultiply(color) // used because we can't animate foreground
                        
                }
                .accessibility(label: Text(configuration.isOn ? "Powered On" : "Powered Off"))
                .aspectRatio(1, contentMode: .fit)
                .imageScale(.small)
                .frame(width: 25, height: 20)
            }
        }
        .buttonStyle(.plain)
        .onAppear {
            color = configuration.isOn ? activeColor : .secondary
        }
    }
}
