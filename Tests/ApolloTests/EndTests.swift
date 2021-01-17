import XCTest
@testable import Apollo

final class EndTests: XCTestCase {
    
    private let input = "Some text"[...]
    private let failureCause = "Input is not empty"
    
    func testReturnsSuccessWhenInputIsEmpty() {
        let parser = End<Substring, Substring>()
        XCTAssertEqual(parser.parse(emptyText), .success(emptyText, emptyText))
    }
    
    func testReturnsFailureWhenInputIsNotEmpty() {
        let parser = End<Substring, Substring>()
        XCTAssertEqual(parser.parse(input), .failure(failureCause, input))
    }

}
