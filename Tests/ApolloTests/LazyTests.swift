import XCTest
@testable import Apollo

final class LazyTests: XCTestCase {
    
    func test_given_a_parser_factory_when_parse_the_input_then_the_factory_lazily_creates_the_parser_and_returns_result_form_the_parser() {
        var executions = 0
        let parser = Lazy<SuccessStub, Substring> {
            executions += 1
            return SuccessStub(value: "A")
        }
        XCTAssertEqual(executions, 0)
        _ = parser.parse("AB")
        XCTAssertEqual(executions, 1)
        _ = parser.parse("AB")
        XCTAssertEqual(executions, 1)
    }

}
