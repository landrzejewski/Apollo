extension Parser {
    
    public func eraseToAnyParser() -> AnyParser<Self, Output> {
        .init(from: self)
    }
    
}

public struct AnyParser<SomeParser, Output>: Parser where SomeParser: Parser {
    
    let parser: SomeParser
    
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
