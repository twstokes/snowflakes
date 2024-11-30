import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private var renderer: SnowRenderer?
    private lazy var statusItem = StatusItem()

    func applicationDidFinishLaunching(_: Notification) {
        let renderer = SnowRenderer()
        renderer.toggle(appSettings: AppSettingsManager.shared.appSettings)
        let settingsView = SettingsView(renderer: renderer).toVC()
        statusItem.setup(contentVC: settingsView)

        self.renderer = renderer
    }

    func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        return true
    }
}
