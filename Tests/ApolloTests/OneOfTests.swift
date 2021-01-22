import XCTest
@testable import Apollo

final class OneOfTests: XCTestCase {
    
    func test_given_a_no() {
        let parser = SuccessStub(value: "A").orElse(SuccessStub(value: "B"))
        XCTAssertEqual(parser.parse("AB"), .success("A", "B"))
    }
    
    func test_given_a_dno() {
        let parser = Failure(cause: testFailureCause).orElse(SuccessStub(value: "A"))
        XCTAssertEqual(parser.parse("AB"), .success("A", "B"))
    }
    
    func test_given_a_fdno() {
        let parser = Failure(cause: testFailureCause).orElse(Failure(cause: testFailureCause))
        XCTAssertEqual(parser.parse("AB"), .failure("Both parsers failed", "AB"))
    }
    
    func test_given_a_sfdno() {
        let parser = OneOf(parsers: SuccessStub(value: "A"), SuccessStub(value: "B"))
        XCTAssertEqual(parser.parse("AB"), .success("A", "B"))
    }
    
    func test_given_a_sfdddno() {
        let parser = OneOf(parsers: StartsWith(prefix: "B"), StartsWith(prefix: "A"))
        XCTAssertEqual(parser.parse("AB"), .success("A", "B"))
    }
    
    func test_given_a_fdnof() {
        let parser = OneOf(parsers: Failure(cause: testFailureCause), Failure(cause: testFailureCause))
        XCTAssertEqual(parser.parse("AB"), .failure("All parsers failed", "AB"))
    }
    
}
