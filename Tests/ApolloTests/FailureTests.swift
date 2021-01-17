import XCTest
@testable import Apollo

final class FailureTests: XCTestCase {
    
    private let input = "Some text"[...]
    private let failureCause = "Test failure"
    
    func testReturnsFailureWithoutConsumingInput() {
        let parser = Failure<Substring, Substring>(causedBy: failureCause)
        XCTAssertEqual(parser.parse(input), .failure(failureCause, input))
    }

}
