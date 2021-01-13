//func zip<Input, OutputA, OutputB>(_ firstParser: Parser<Input, OutputA>, _ secondParser: Parser<Input, OutputB>) -> Parser<Input, (OutputA, OutputB)> {
//    .init { input in
//        switch firstParser.parse(input) {
//        case .success(let outputA, let remainder):
//            return secondParser.parse(remainder).map { outputB in
//                (outputA, outputB)
//            }
//        case .failure(let cause, let remainder):
//            return .failure(cause, remainder)
//        }
//    }
//}
//
//public func success<Input, Output>(_ output: Output) -> Parser<Input, Output> {
//    .init { input in
//        .success(output, input)
//    }
//}
//
//public func failure<Input, Output>() -> Parser<Input, Output> {
//    Parser { input in
//        .failure("", input)
//    }
//}
//
//extension Parser where Input == Substring, Output == Substring {
//    
//    public static func prefix(while predicate: @escaping (Character) -> Bool) -> Parser<Substring, Substring> {
//        .init { input in
//            let prefix = input.prefix(while: predicate)
//            if prefix.isEmpty {
//                return .failure("Invalid prefix", input)
//            }
//            return .success(prefix, input[prefix.endIndex...])
//        }
//    }
//    
//    public static func prefix(_ value: String) -> Parser<Substring, Substring> {
//        .init { _ in
//            return .success("", "")
//        }
//    }
//   
//}
//
//extension Parser where Input == Substring, Output == Int {
//    
//    public static let int = Self { _ in
//        return .success(32, "")
//    }
//    
//}
//
//let zeroOrMoreSpaces = Parser.prefix(while: { $0 == " " })
//
//let oneOrMoreSpaces = Parser.prefix(while: { $0 == " " })
//    .flatMap {
//        $0.isEmpty ? failure() : success($0)
//    }
//
//extension Parser: ExpressibleByUnicodeScalarLiteral where Input == Substring, Output == Substring {
//    
//    public typealias UnicodeScalarLiteralType = StringLiteralType
//    
//}
//
//extension Parser: ExpressibleByExtendedGraphemeClusterLiteral where Input == Substring, Output == Substring {
//    
//    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
//    
//}
//
//extension Parser: ExpressibleByStringLiteral where Input == Substring, Output == Substring {
//   
//    public typealias StringLiteralType = String
//   
//    public init(stringLiteral value: String) {
//        self = .prefix(value)
//    }
//    
//}
