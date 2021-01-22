import XCTest
@testable import Apollo

final class SkipTests: XCTestCase {
    
    func test_given_two_not_failing_parsers_when_parse_the_input_then_returns_success_with_value_from_the_first_parser_and_input_remainder() {
        let parser = SuccessStub(value: "A").skipNext(SuccessStub(value: "B"))
        XCTAssertEqual(parser.parse("AB"), .success("A", emptySequence))
    }
    
    func test_given_two_not_failing_parsers_when_parse_the_input_then_returns_success_with_value_from_second_the_parser_and_input_remainder() {
        let parser = SuccessStub(value: "A").skipPrevious(SuccessStub(value: "B"))
        XCTAssertEqual(parser.parse("AB"), .success("B", emptySequence))
    }
    
    func test_given_failing_and_not_failing_parsers_when_parse_the_input_then_returns_failure_and_the_input() {
        let parser = FailureStub(cause: testFailureCause).skipNext(SuccessStub(value: "A"))
        XCTAssertEqual(parser.parse("AB"), .failure(testFailureCause, "AB"))
    }
    
    func test_given_not_failing_and_failing_parsers_when_parse_the_input_then_returns_failure_and_the_input() {
        let parser = SuccessStub(value: "A").skipNext(FailureStub(cause: testFailureCause))
        XCTAssertEqual(parser.parse("AB"), .failure(testFailureCause, "AB"))
    }
    
}
