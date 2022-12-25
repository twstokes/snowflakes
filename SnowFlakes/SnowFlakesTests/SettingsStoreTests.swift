import Foundation


import XCTest
@testable import SnowFlakes

class StoreTests: XCTestCase {
    private var userDefaults: UserDefaults!

    override func setUpWithError() throws {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
    }

    override func tearDownWithError() throws {
    }

    func testStoringAppState() throws {
        let expected: Float = 12345.0

        let expectation = expectation(description: "successfully written")
        let store = UserDefaultsStore(userDefaults: userDefaults) { result in
            switch result {
            case .success(let appState):
                XCTAssertEqual(appState.size, expected)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        let nilAppState = try store.loadAppState()
        XCTAssertNil(nilAppState)

        let appState = AppSettings.defaults
        XCTAssertNotEqual(appState.size, expected)
        store.observe(appState)
        appState.size = expected

        wait(for: [expectation], timeout: 3)
    }
}
