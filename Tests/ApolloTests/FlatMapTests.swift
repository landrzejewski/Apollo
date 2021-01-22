import XCTest
@testable import Apollo

final class FlatMapTests: XCTestCase {
    
    func test_given_a_not_failing_parser_and_a_transform_when_parse_the_input_then_returns_result_form_the_parser_parsed_with_a_parser_created_by_the_transform() {
        let parser = SuccessStub(value: "A").flatMap { SuccessStub(value: $0.lowercased()[...])}
        XCTAssertEqual(parser.parse("AB"), .success("a", emptySequence))
    }
    
    func test_given_a_not_failing_parser_and_a_transform_that_creates_a_failing_parser_when_parse_the_input_then_returns_failure_with_the_input_without_applying_the_transform() {
        let parser = SuccessStub(value: "A").flatMap { _ in FailureStub(cause: testFailureCause) }
        XCTAssertEqual(parser.parse("AB"), .failure(testFailureCause, "AB"))
    }

    func test_given_a_failing_parser_and_a_transform_when_parse_the_input_then_returns_failure_with_the_input_without_applying_the_transform() {
        let parser = FailureStub(cause: testFailureCause).flatMap { SuccessStub(value: $0.lowercased()[...] )}
        XCTAssertEqual(parser.parse("AB"), .failure(testFailureCause, "AB"))
    }
    
}
