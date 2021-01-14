import XCTest
@testable import Apollo

final class ApolloTests: XCTestCase {

    func testExample() {
        
        print(Success(output: "test")
                .zip(Success(output: "test"))
                .zip(Success(output: "test"))
                .zip(Rest<Substring, Substring>())
                .map { $0.0 }
                .parse("ala ma kota")
                
        
        
        )
//
//        let a: Parser<Substring, Substring> = Parser.prefix(while: { !$0.isNumber })
//
////        print(a)
////        let b = prefix(while: { $0.isNumber }).parse("3a")
////        print(b)
//        
//        let c = Parser.prefix(while: { $0.isNumber })
//            .zip(", ")
//            .zip(.prefix(while: { $0.isNumber }))
//                .parse("23a2")
//        print(c)
//
//        
//        print(a
//                .skip(.prefix(while: { !$0.isNumber }))
//                .zip(.prefix(while: { $0.isNumber }))
//            .parse("23a2"))
            
        
        
//        switch prefix(while: { $0.isNumber })
//            .flatMap({ _ in success(1) })
//            .parse("2october1981") {
//        case .success(let value, let remainder):
//            print("value: \(value), remainder: \(remainder)")
//        case .failure(let remainder):
//            print("remainder: \(remainder)")
//        }
    }

}
