import XCTest
@testable import Apollo

final class PipeTests: XCTestCase {
    
    func test_given_two_parsers_when_parse_the_input_then_returns_result_from_second_parser_which_parses_result_from_first_parser() {
        let parser = SuccessStub(value: "A").pipe(SuccessStub(value: "B"))
        XCTAssertEqual(parser.parse("AB"), .success("B", emptySequence))
    }
    
    func test_given_two_parsers_and_the_first_parser_is_faling_when_parse_the_input_then_returns_failure_and_the_input() {
        let parser = FailureStub(cause: testFailureCause).pipe(SuccessStub(value: "B"))
        XCTAssertEqual(parser.parse("AB"), .failure(testFailureCause, "AB"))
    }

}
