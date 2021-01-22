import XCTest
@testable import Apollo

final class ManyTests: XCTestCase {
    
    func test_given_three_not_failing_parser() {
        let parser = Many(parser: StartsWith(prefix: "A"), separator: StartsWith(prefix: ","))
        XCTAssertEqual(parser.parse("A,A,A,BAB"), .success(["A", "A", "A"], "BAB"))
    }
    
    func test_given_three_not_failing_pareser() {
        let parser = Many(parser: StartsWith(prefix: "A"), separator: StartsWith(prefix: ","), atLeast: 5)
        XCTAssertEqual(parser.parse("A,A,AABAB"), .failure("Too few elemnets", "A,A,AABAB"))
    }
    
    func test_given_three_not_failing_paresser() {
        let parser = Many(parser: StartsWith(prefix: "A"), separator: StartsWith(prefix: ","), atLeast: 5)
        XCTAssertEqual(parser.parse("A,A,A,BAB"), .failure("Too few elemnets", "A,A,A,BAB"))
    }
    
    func test_given_three_not_faidling_paresser() {
        let parser = Many(parser: StartsWith(prefix: "A"), separator: StartsWith(prefix: ","), atMost: 2)
        XCTAssertEqual(parser.parse("A,A,A,BAB"), .success(["A", "A"], "A,BAB"))
    }
    
    func test_given_three_not_failing_parsder() {
        let parser = Many(parser: StartsWith(prefix: "A"), separator: empty)
        XCTAssertEqual(parser.parse("AAABAB"), .success(["A", "A", "A"], "BAB"))
    }
    
}
