import XCTest
@testable import CLInterface

final class CLInterfaceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CLInterface().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
