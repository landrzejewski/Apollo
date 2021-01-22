import XCTest
@testable import Apollo

final class StreamTests: XCTestCase {
    
    func test_given_two_parsers() {
        let stream = AnyIterator(
            sequence(state: 0) { state -> Substring? in
                state += 1
                return state <= 20 ? Substring("\(state)\(state)\n") : nil
            }
        )
        
        let parser = Prefix(while: { $0.isNumber }).skipNext(StartsWith(prefix: "\n")).stream
    
        switch parser.parse(stream) {
        case .success(let value, let remainder):
            print(value)
            print(remainder)
        case .failure(let cause, let remainder):
            print(cause)
            print(remainder)
        }
    }
    
}
