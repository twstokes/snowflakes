import AppKit
import Foundation
import SwiftUI

extension SettingsView {
    func toVC() -> NSViewController {
        return NSHostingController(rootView: environmentObject(AppSettingsManager.shared))
    }
}
