import XCTest
@testable import Apollo

final class FailureTests: XCTestCase {
    
    func test_given_a_cause_when_parse_the_input_then_returns_failure_with_the_cause_and_the_input() {
        let parser = Failure(cause: testFailureCause)
        XCTAssertEqual(parser.parse(testInput), .failure(testFailureCause, testInput))
    }
    
}
