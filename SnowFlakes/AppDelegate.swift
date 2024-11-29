import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private lazy var statusItem = StatusItem()
    private var renderer: SnowRenderer?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        renderer = SnowRenderer()
        let settingsView = SettingsView(renderer: renderer).toVC()
        statusItem.setup(contentVC: settingsView)
        renderer?.start(appSettings: AppSettingsManager.shared.appSettings)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
