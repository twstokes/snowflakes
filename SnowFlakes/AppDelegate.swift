import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private lazy var statusItem = StatusItem()
    private var renderer: SnowRenderer?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let renderer = SnowRenderer()
        renderer.toggle(appSettings: AppSettingsManager.shared.appSettings)
        let settingsView = SettingsView(renderer: renderer).toVC()
        statusItem.setup(contentVC: settingsView)

        self.renderer = renderer
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
