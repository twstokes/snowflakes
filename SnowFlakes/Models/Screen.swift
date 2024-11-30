import AppKit
import Foundation

/// The purpose of this model is to support enabling and disabling screens.
struct Screen: Hashable, Identifiable {
    let enabled: Bool
    let id: CGDirectDisplayID

    var nsScreen: NSScreen? {
        NSScreen.screens.first(where: { $0.cgDirectDisplayID == id })
    }
}

extension NSScreen {
    /// https://developer.apple.com/documentation/appkit/nsscreen/1388360-devicedescription
    var cgDirectDisplayID: CGDirectDisplayID? {
        let key = NSDeviceDescriptionKey("NSScreenNumber")
        return deviceDescription[key] as? CGDirectDisplayID
    }
}
