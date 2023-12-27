import Foundation
import AppKit

extension NSApplication {
    var overlayWindows: [OverlayWindow] {
        return windows.compactMap { $0 as? OverlayWindow }
    }
}
