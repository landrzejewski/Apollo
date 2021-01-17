import XCTest
@testable import Apollo

final class SuccessTests: XCTestCase {
    
    private let input = "Some text"[...]
    private let value = "Some value"[...]
    
    func testReturnsSuccessWithoutConsumingInput() {
        let parser = Success<Substring, Substring>(value)
        XCTAssertEqual(parser.parse(input), .success(value, input))
    }

}
