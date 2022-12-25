import Foundation
import AppKit

/// The purpose of this model is to support enabling and disabling screens.
struct Screen: Hashable, Identifiable {
    let enabled: Bool
    let id: Int
    
    var nsScreen: NSScreen? {
        NSScreen.screens.first(where: { $0.uniqueId == id })
    }
}

/// a couple things:
/// 1. we may want to assume this will stop working at some point, so if zero screens are found on init, maybe we just disable the feature and enabled it on all screens
/// 2. evidently IDs can change when the system toggles between discrete and onboard GPUs (https://stackoverflow.com/a/11621716)
/// in this case, we may want to never clear previous screen IDs.
extension NSScreen {
    var uniqueId: Int? {
        let screenNumberKey = NSDeviceDescriptionKey.init(rawValue: "NSScreenNumber")
        return deviceDescription[screenNumberKey] as? Int
    }
}
