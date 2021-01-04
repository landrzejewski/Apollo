import XCTest
import SwiftHamcrest
@testable import Apollo

final class ApolloTests: XCTestCase {
    
    func testExample() {
        switch prefix(while: { !$0.isNumber }).map({ $0.uppercased() }).parse("october1981") {
        case .success(let output, let input):
            print(output)
            print(input)
        default:
            print("failure")
        }
    }
    
}
