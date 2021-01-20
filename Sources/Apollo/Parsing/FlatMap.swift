extension Parser {
    
    public func flatMap<OtherParser>(_ transform: @escaping (Output) -> OtherParser) -> Parsers.FlatMap<OtherParser, Self> {
        .init(parser: self, transform: transform)
    }
    
}

extension Parsers {
    
    public struct FlatMap<OtherParser, SomeParser>: Parser where OtherParser: Parser, SomeParser: Parser, OtherParser.Input == SomeParser.Input {
        
        private let parser: SomeParser
        private let transform: (SomeParser.Output) -> OtherParser
        
        public init(parser: SomeParser, transform: @escaping (SomeParser.Output) -> OtherParser) {
            self.parser = parser
            self.transform = transform
        }
        
        public func parse(_ input: SomeParser.Input) -> Result<OtherParser.Output, SomeParser.Input> {
            switch parser.parse(input).map(transform) {
            case .success(let newParser, let remainder):
                return newParser.parse(remainder).get(originalRemainder: input)
            case .failure(let cause, let remainder):
                return .failure(cause, remainder)
            }
        }
        
    }
    
}
