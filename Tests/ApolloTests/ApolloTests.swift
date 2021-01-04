import XCTest
import SwiftHamcrest
@testable import Apollo

final class ApolloTests: XCTestCase {
    
    func testExample() {
        switch prefix(while: { $0.isNumber })
            .flatMap({ _ in success(1) })
            .parse("2october1981") {
        case .success(let value, let remainder):
            print("value: \(value), remainder: \(remainder)")
        case .failure(let remainder):
            print("remainder: \(remainder)")
        }
    }
    
}
