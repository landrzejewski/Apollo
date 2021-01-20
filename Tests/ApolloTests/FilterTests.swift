import XCTest
@testable import Apollo

final class FilterTests: XCTestCase {
    
    func test_given_a_not_failing_parser_and_a_fulfilled_predicate_when_parse_the_input_then_returns_result_form_the_parser() {
        let parser = SuccessStub(value: testValue).filter { $0.contains(testValue.prefix(1)) }
        XCTAssertEqual(parser.parse(testInput), .success(testValue, testInputConsumed))
    }
    
    func test_given_a_not_failing_parser_and_an_unfulfilled_predicate_when_parse_the_input_then_returns_failure_and_the_input() {
        let parser = SuccessStub(value: testValue).filter { !$0.contains(testValue.prefix(1)) }
        XCTAssertEqual(parser.parse(testInput), .failure("The condition is not met", testInput))
    }
    
    func test_given_a_failing_parser_when_parse_the_input_then_returns_result_form_the_parser_without_checking_the_predicate() {
        let parser = FailureStub(cause: testFailureCause).filter { $0.contains(testValue.prefix(1)) }
        XCTAssertEqual(parser.parse(testInput), .failure(testFailureCause, testInput))
    }
    
}
