import XCTest
@testable import Apollo

final class NewLineTests: XCTestCase {
    
    func test_given_an_input_with_line_feed_when_parse_the_input_then_returns_success_and_consumes_new_line() {
        XCTAssertEqual(NewLine().parse("\nAB"), .success("\n", "AB"))
    }
    
    func test_given_an_input_with_carriage_return_and_line_feed_when_parse_the_input_then_returns_success_and_consumes_new_line() {
        XCTAssertEqual(NewLine().parse("\r\nAB"), .success("\r\n", "AB"))
    }
    
    func test_given_an_input_without_new_line_when_parse_the_input_then_returns_failure_with_the_input() {
        XCTAssertEqual(NewLine().parse("AB"), .failure("New line not found", "AB"))
    }
    
}
