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
    
    func remainder() -> Remainder<Substring.UTF8View, Substring.UTF8View> {
        Remainder()
    }
    
    func whitespace() -> Whitespace<Substring.UTF8View, Substring.UTF8View>  {
        Whitespace()
    }
    
    func testStartsWith() {
        let a = """
        ### ala ma kota
        Paragraf
        """[...].utf8
        
        let result = Prefix<Substring.UTF8View, Substring.UTF8View>(3)
            .skip(whitespace())
            .zip(remainder())
            .map { String($0.1) }
            .parse(a)
        
        
        switch result {
        
        
        case .success(let value, let r):
            print("Value: \(value)")
            print("Remainder: \(r)")
            
        case .failure(let awake, let a):
            print("aa")
        }
        
        
    }
    
   
    
}


