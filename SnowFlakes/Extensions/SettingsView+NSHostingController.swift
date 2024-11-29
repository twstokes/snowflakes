import Foundation
import AppKit
import SwiftUI

extension SettingsView {
    func toVC() -> NSViewController {
        return NSHostingController(rootView: self.environmentObject(AppSettingsManager.shared))
    }
}
