import XCTest
@testable import Apollo

final class AnyParserTests: XCTestCase {
    
    func test_given_an_erased_parser_when_parse_the_input_then_returns_result_form_the_original_parser() {
        let parser = SuccessStub(value: testInput).eraseToAnyParser().eraseToAnyParser()
        XCTAssertEqual(parser.parse(testInput), .success(testValue, testInputConsumed))
    }
    
}
