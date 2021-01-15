import XCTest
@testable import Apollo

final class ApolloTests: XCTestCase {

    func testExample() {
        
  
        
        print(levenshteinDistance(firstWord: "Łukasz", secondWord: "luk"))
        
        
         struct Literal<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
            
            public typealias Output = Input
            
            public func parse(_ input: Input) -> Result<Input, Input> {
                .success(input, input)
            }
            
        }
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
