import XCTest
@testable import Apollo

final class AnyParserTests: XCTestCase {
    
    private let input = "Some text"[...]
    private let value = "Some value"[...]
    
    func testReturnsSuccessFromOriginalParser() {
        let parserStub = SuccessStub<Substring, Substring>(with: value)
        let parser = parserStub.eraseToAnyParser()
        XCTAssertEqual(parser.parse(input), .success(value, input))
    }
    
    func testReturnsFailureFromOriginalParser() {
        let parserStub = FailureStub<Substring, Substring>()
        let parser = parserStub.eraseToAnyParser()
        XCTAssertEqual(parser.parse(input), .failure(parserStub.cause, input))
    }

    
    func testStartsWith() {
        print(PrefixUpTo<Substring, Substring>("\n")
        .parse("Hellow\nWorld\n"))

    }
}
