import XCTest
@testable import Apollo

final class SuccessTests: XCTestCase {
    
    func test_given_a_value_when_parse_the_input_then_returns_success_with_the_value_and_the_input() {
        XCTAssertEqual(Success(value: testValue).parse(testInput), .success(testValue, testInput))
    }
    
}
