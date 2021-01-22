import XCTest
@testable import Apollo

final class PrefixTests: XCTestCase {
    
    func test_1() {
        XCTAssertEqual(Prefix(1).parse(emptySequence), .failure("Prefix not found", ""))
    }
    
    func test_2() {
        XCTAssertEqual(Prefix(1).parse("ABC"), .success("A", "BC"))
    }
    
    func test_3() {
        XCTAssertEqual(Prefix(4).parse("ABC"), .failure("Prefix not found", "ABC"))
    }
    
    func test_4() {
        XCTAssertEqual(Prefix(1...).parse("ABC"), .success("ABC", emptySequence))
    }
    
    func test_5() {
        XCTAssertEqual(Prefix(...2).parse("ABC"), .success("AB", "C"))
    }
    
    func test_6() {
        XCTAssertEqual(Prefix(...100).parse("ABC"), .success("ABC", emptySequence))
    }
    
    func test_7() {
        XCTAssertEqual(Prefix(1...3).parse("ABC"), .success("ABC", emptySequence))
    }

    func test_8() {
        XCTAssertEqual(Prefix(5...100).parse("ABC"), .failure("Prefix not found", "ABC"))
    }
    
    func test_9() {
        XCTAssertEqual(Prefix(while: { $0.isNumber }).parse("345ABC"), .success("345", "ABC"))
    }
    
    func test_10() {
        XCTAssertEqual(Prefix(1) { $0.isNumber }.parse("345ABC"), .failure("Prefix not found", "345ABC"))
    }
    
    func test_11() {
        XCTAssertEqual(Prefix(1...) { $0.isNumber }.parse("345ABC"), .success("345", "ABC"))
    }
    
    func test_12() {
        XCTAssertEqual(Prefix(...3) { $0.isNumber }.parse("345ABC"), .success("345", "ABC"))
    }
    
    func test_13() {
        XCTAssertEqual(Prefix(1...2) { $0.isNumber }.parse("345ABC"), .failure("Prefix not found", "345ABC"))
    }
    
    func test_14() {
        XCTAssertEqual(Prefix(1...3) { $0.isNumber }.parse("345ABC"), .success("345", "ABC"))
    }

}
