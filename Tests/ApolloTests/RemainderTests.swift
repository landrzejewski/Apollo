import XCTest
@testable import Apollo

final class RemainderTests: XCTestCase {
    
    private let input = "Some text"[...]
    
    func testReturnsSuccessAndConsumesInput() {
        let parser = Remainder<Substring, Substring>()
        XCTAssertEqual(parser.parse(input), .success(input, emptyText))
    }
    
    func testReturnsSuccessWhenInputIsEmpty() {
        let parser = Remainder<Substring, Substring>()
        XCTAssertEqual(parser.parse(emptyText), .success(emptyText, emptyText))
    }

}
