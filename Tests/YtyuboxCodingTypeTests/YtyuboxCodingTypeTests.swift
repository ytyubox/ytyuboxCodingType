import XCTest
@testable import YtyuboxCodingType

final class YtyuboxCodingTypeTests: XCTestCase {
    func testAnyError() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
      XCTAssertThrowsError( try {
        throw AnyError("should throws error")
        }()
      )
    }

    static var allTests = [
        ("testAnyError", testAnyError),
    ]
}
