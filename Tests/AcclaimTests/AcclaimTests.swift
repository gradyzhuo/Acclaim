import XCTest
@testable import Acclaim

final class AcclaimTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Acclaim().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
