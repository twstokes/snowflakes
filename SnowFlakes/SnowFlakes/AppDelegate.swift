import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private lazy var stateStore = UserDefaultsStore()
    private lazy var statusItem = StatusItem()
    private lazy var renderer = SnowRenderer()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let appSettings = (try? stateStore.loadAppState()) ?? AppSettings.defaults
        let settingsView = SettingsView(appSettings: appSettings).toVC()
        statusItem.setup(contentVC: settingsView)
        stateStore.observe(appSettings)
        renderer.observe(appSettings)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
