public protocol Parser {
    
    associatedtype Input
    associatedtype Output
    
    func parse(_ input: Input) -> Result<Output, Input>
    
}

//public struct Parser<Input, Output> {
//    
//    public let parse: (_ input: Input) -> Result<Output, Input>
//    
//    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Parser<Input, NewOutput> {
//        .init { input in
//            parse(input).map(transform)
//        }
//    }
//    
//    public func flatMap<NewOutput>(_ transform: @escaping (Output) -> Parser<Output, NewOutput>) -> Parser<Output, NewOutput> where Input == Output {
//        .init { input in
//            switch parse(input).map(transform) {
//            case .success(let parser, let remainder):
//                return parser.parse(remainder).get(originalRemainder: input)
//            case .failure(let cause, let remainder):
//                return .failure(cause, remainder)
//            }
//        }
//    }
//    
//    func zip<OutputB>(_ secondParser: Parser<Input, OutputB>) -> Parser<Input, (Output, OutputB)> {
//        .init { input in
//            switch parse(input) {
//            case .success(let output, let remainder):
//                return secondParser.parse(remainder).combine(with: output, originalRemainder: input)
//            case .failure(let cause, let remainder):
//                return .failure(cause, remainder)
//            }
//        }
//    }
//    
//    func zip<OutputA, OutputB, OutputC>(_ parserC: Parser<Input, OutputC>) -> Parser<Input, (OutputA, OutputB, OutputC)> where Output == (OutputA, OutputB) {
//        zip(parserC).map { parsers, parserC in
//            (parsers.0, parsers.1, parserC)
//        }
//    }
//    
//    func skip<OtherOutput>(_ parser: Parser<Input, OtherOutput>) -> Parser {
//        zip(parser).map { outputA, _ in
//            outputA
//        }
//    }
//    
//}
