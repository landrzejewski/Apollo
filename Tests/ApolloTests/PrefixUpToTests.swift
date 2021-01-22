import XCTest
@testable import Apollo

final class PrefixUpToTests: XCTestCase {
    
    func test_given_a_no() {
        XCTAssertEqual(PrefixUpTo(", ").parse("A, B"), .success("A", ", B"))
    }
    
    func test_given_a_no2() {
        XCTAssertEqual(PrefixUpTo(emptySequence).parse("A, B"), .failure("Prefix is empty", "A, B"))
    }
    
    func test_given_a_no3() {
        XCTAssertEqual(PrefixUpTo(", ").parse("AB"), .failure("Prefix not found", "AB"))
    }
    
}
