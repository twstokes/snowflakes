import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private lazy var renderer = SnowRenderer()
    private lazy var statusItem = StatusItem()

    func applicationDidFinishLaunching(_: Notification) {
        let settingsView = SettingsView().toVC()
        statusItem.setup(contentVC: settingsView)
    }

    func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        return true
    }
}
