import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private lazy var renderer = SnowRenderer()
    private lazy var statusItem = StatusItem()
    private lazy var store = FileManagerStore()

    func applicationDidFinishLaunching(_: Notification) {
        let appSettings = store.loadAppSettings()
        let settingsView = SettingsView(appSettings: appSettings).toVC()
        statusItem.setup(contentVC: settingsView)
        renderer.observe(appSettings)
        store.observe(appSettings)
    }

    func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        return true
    }

    func applicationDidChangeScreenParameters(_ notification: Notification) {
        renderer.reload()
    }
}
