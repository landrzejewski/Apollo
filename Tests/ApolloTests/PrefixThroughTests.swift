import XCTest
@testable import Apollo

final class PrefixThroughTests: XCTestCase {
    
    func test_given_a_no() {
        XCTAssertEqual(PrefixThrough(", ").parse("A, B"), .success("A, ", "B"))
    }
    
    func test_given_a_no2() {
        XCTAssertEqual(PrefixThrough(emptySequence).parse("A, B"), .failure("Prefix is empty", "A, B"))
    }
    
    func test_given_a_no3() {
        XCTAssertEqual(PrefixThrough(", ").parse("AB"), .failure("Prefix not found", "AB"))
    }
    
}
