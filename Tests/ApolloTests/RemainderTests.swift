import XCTest
@testable import Apollo

final class RemainderTests: XCTestCase {
    
    func test_given_a_non_empty_input_when_parse_the_input_then_returns_success_with_the_input_and_an_empty_remainder() {
        XCTAssertEqual(Remainder().parse(testInput), .success(testInput, emptySequence))
    }
    
    func test_given_an_empty_input_when_parse_the_input_then_returns_success_with_an_empty_value_and_an_empty_remainder() {
        XCTAssertEqual(Remainder().parse(emptySequence), .success(emptySequence, emptySequence))
    }
    
}
