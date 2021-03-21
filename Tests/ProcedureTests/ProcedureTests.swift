import XCTest
@testable import Procedure

final class ProcedureTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let step = SimpleStep { (intents, callback) in
            print(intents)
            callback(.succeed)
        }

        step.run(with: SimpleIntent(command: "hello"))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
