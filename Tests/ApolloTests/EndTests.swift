import XCTest
@testable import Apollo

final class EndTests: XCTestCase {
    
    func test_given_an_empty_input_when_parse_the_input_then_returns_success_with_an_empty_value_and_an_empty_remainder() {
        XCTAssertEqual(End().parse(emptyText), .success(emptyText, emptyText))
    }
    
    func test_given_a_non_empty_input_when_parse_the_input_then_returns_failure_with_the_input() {
        XCTAssertEqual(End().parse(testInput), .failure("Input is not empty", testInput))
    }
    
}
