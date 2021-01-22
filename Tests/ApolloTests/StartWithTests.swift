import XCTest
@testable import Apollo

final class StartWithTests: XCTestCase {
    
    func test_given_a_no() {
        XCTAssertEqual(StartsWith(prefix: "AB").parse("ABC"), .success("AB", "C"))
    }
    
    func test_given_a_n3o() {
        XCTAssertEqual(StartsWith(prefix: "C").parse("ABC"), .failure("Prefix not found", "ABC"))
    }
    
}
