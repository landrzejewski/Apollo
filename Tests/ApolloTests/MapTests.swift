import XCTest
@testable import Apollo

final class MapTests: XCTestCase {
    
    func test_given_a_not_failing_parser_and_a_transform_when_parse_the_input_then_returns_success_with_the_value_mapped_by_the_transform() {
        let parser = SuccessStub(value: "A").map { "\($0)\($0)" }
        XCTAssertEqual(parser.parse("AB"), .success("AA", "B"))
    }
    

    func test_given_a_failing_parser_and_a_transform_when_parse_the_input_then_returns_failure_with_the_input_without_applying_the_transform() {
        let parser = FailureStub(cause: testFailureCause).map { "\($0)\($0)" }
        XCTAssertEqual(parser.parse("AB"), .failure(testFailureCause, "AB"))
    }
    
}
