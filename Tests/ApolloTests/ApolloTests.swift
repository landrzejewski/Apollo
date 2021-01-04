import XCTest
import SwiftHamcrest
import Benchmark
@testable import Apollo

final class ApolloTests: XCTestCase {
    
    func testExample() {
        print(Prefix { $0.isNumber }.parse("2ala ma kota"))
    }
    
}
