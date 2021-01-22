import XCTest
@testable import Apollo

final class WhitespaceTests: XCTestCase {
    
    func test_given_an_input_with_whitespace_characters_when_parse_the_input_then_returns_success_and_consumes_new_line() {
        XCTAssertEqual(Whitespace().parse(" \t\n\rAB"), .success(" \t\n\r", "AB"))
    }

    func test_given_an_input_without_whitespace_characters_when_parse_the_input_then_returns_failure_with_the_input() {
        XCTAssertEqual(Whitespace().parse("AB"), .failure("Whitespace characters not found", "AB"))
    }
    
}
