import XCTest
@testable import Apollo

final class OptionTests: XCTestCase {
    
    private let  condition: ((Substring) -> Option<SuccessStub, SuccessStub>) = {
        $0.isEmpty ? .first(SuccessStub(value: "A")) : .second(SuccessStub(value: "B"))
    }
    
    func test_given_two_parsers_and_a_condition_that_has_been_met_when_parse_the_input_then_returns_result_from_the_first_parser() {
        let parser = SuccessStub(value: emptySequence).flatMap(condition)
        XCTAssertEqual(parser.parse(emptySequence), .success("A", emptySequence))
    }
    
    func test_given_two_parsers_and_a_condition_that_has_not_been_met_when_parse_the_input_then_returns_result_from_the_second_parser() {
        let parser = SuccessStub(value: "A").flatMap(condition)
        XCTAssertEqual(parser.parse("AB"), .success("B", emptySequence))
    }
    
}
