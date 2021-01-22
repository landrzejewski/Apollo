import XCTest
@testable import Apollo

final class ZipTests: XCTestCase {
    
    func test_given_two_not_failing_parsers_when_parse_the_input_then_returns_success_with_values_from_both_parsers_and_the_input_remainder() {
        let parser = SuccessStub(value: "A").zip(SuccessStub(value: "B"))
        switch parser.parse("AB") {
        case .success(let value, let remainder):
            XCTAssertTrue(value == ("A", "B"))
            XCTAssertEqual(remainder, emptySequence)
        case .failure(_, _):
            XCTFail("Expected success")
        }
    }
    
    func test_given_a_failing_and_not_failing_parsers_when_parse_the_input_then_returns_failure_with_the_input() {
        let parser = SuccessStub(value: "A").zip(SuccessStub(value: "B")).zip(FailureStub(cause: testFailureCause))
        switch parser.parse("ABC") {
        case .success(_, _):
            XCTFail("Expeced failure")
        case .failure(let cause, let remainder):
            XCTAssertEqual(cause, testFailureCause)
            XCTAssertEqual(remainder, "ABC")
        }
    }
    
    func test_given_three_not_failing_parsers_when_parse_the_input_then_returns_success_with_values_from_all_three_parsers_and_the_input_remainder() {
        let parser = SuccessStub(value: "A").zip(SuccessStub(value: "B")).zip(SuccessStub(value: "C"))
        switch parser.parse("ABC") {
        case .success(let value, let remainder):
            XCTAssertTrue(value == ("A", "B", "C"))
            XCTAssertEqual(remainder, emptySequence)
        case .failure(_, _):
            XCTFail("Expected success")
        }
    }
    
    func test_given_four_not_failing_parsers_when_parse_the_input_then_returns_success_with_values_from_all_four_parsers_and_the_input_remainder() {
        let parser = SuccessStub(value: "A").zip(SuccessStub(value: "B")).zip(SuccessStub(value: "C")).zip(SuccessStub(value: "D"))
        switch parser.parse("ABCD") {
        case .success(let value, let remainder):
            XCTAssertTrue(value == ("A", "B", "C", "D"))
            XCTAssertEqual(remainder, emptySequence)
        case .failure(_, _):
            XCTFail("Expected success")
        }
    }
    
    func test_given_five_not_failing_parsers_when_parse_the_input_then_returns_success_with_values_from_all_five_parsers_and_the_input_remainder() {
        let parser = SuccessStub(value: "A").zip(SuccessStub(value: "B")).zip(SuccessStub(value: "C")).zip(SuccessStub(value: "D")).zip(SuccessStub(value: "E"))
        switch parser.parse("ABCDE") {
        case .success(let value, let remainder):
            XCTAssertTrue(value == ("A", "B", "C", "D", "E"))
            XCTAssertEqual(remainder, emptySequence)
        case .failure(_, _):
            XCTFail("Expected success")
        }
    }
    
}
