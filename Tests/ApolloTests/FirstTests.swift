import XCTest
@testable import Apollo

final class FirstTests: XCTestCase {
    
    func test_given_a_non_empty_input_when_parse_the_input_then_returns_success_with_first_element_of_the_input_and_the_input_remainder() {
        XCTAssertEqual(First().parse(testInput), .success(testInput.prefix(1), testInput.dropFirst()))
    }
    
    func test_given_an_empty_input_when_parse_the_input_then_returns_failure_with_an_empty_remainder() {
        XCTAssertEqual(First().parse(emptyText), .failure("Input has no elements", emptyText))
    }
    
}
