extension Parser {
    
    public func eraseToAnyParser() -> Parsers.AnyParser<Self, Output> {
        .init(from: self)
    }
    
}

extension Parsers {
    
    public struct AnyParser<SomeParser, Output>: Parser where SomeParser: Parser {
        
        private let parser: SomeParser
        
        public init(from parser: SomeParser) {
            self.parser = parser
        }
        
        public func parse(_ input: SomeParser.Input) -> Result<SomeParser.Output, SomeParser.Input> {
            parser.parse(input)
        }
        
        public func eraseToAnyParser() -> Self {
            self
        }
        
    }
    
}
