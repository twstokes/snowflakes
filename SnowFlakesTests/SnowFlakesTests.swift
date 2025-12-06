@testable import SnowFlakes
import XCTest

final class FileManagerStoreTests: XCTestCase {
    private var tempDirectory: URL!

    override func setUpWithError() throws {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        tempDirectory = base
    }

    override func tearDownWithError() throws {
        if let tempDirectory {
            try? FileManager.default.removeItem(at: tempDirectory)
        }
        tempDirectory = nil
    }

    private func makeStore(bundle: Bundle = .main) -> FileManagerStore {
        FileManagerStore(
            fileManager: .default,
            bundle: bundle,
            applicationSupportDirectory: tempDirectory
        )
    }

    func testLoadReturnsDefaultsWhenNoSettingsFileExists() throws {
        let store = makeStore()
        let loaded = store.loadAppSettings()
        XCTAssertEqual(loaded.enabled, AppSettings.defaults.enabled)
        XCTAssertEqual(loaded.size, AppSettings.defaults.size)
    }

    func testObservePersistsChangesToProvidedDirectory() throws {
        let store = makeStore()
        let settings = AppSettings.defaults
        store.observe(settings)

        settings.enabled = true
        settings.size = 5
        settings.alwaysOnTop = true

        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.4))

        let persisted = store.loadAppSettings()
        XCTAssertTrue(persisted.enabled)
        XCTAssertEqual(persisted.size, 5)
        XCTAssertTrue(persisted.alwaysOnTop)

        let bundleIdentifier = Bundle.main.bundleIdentifier ?? ProcessInfo.processInfo.processName
        let expectedDirectory = tempDirectory.appendingPathComponent(bundleIdentifier, isDirectory: true)
        let expectedFile = expectedDirectory.appendingPathComponent("settings.json")
        XCTAssertTrue(FileManager.default.fileExists(atPath: expectedFile.path))
    }
}
