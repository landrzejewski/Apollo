extension Parser {
    
    public func filter(_ preicate: @escaping (Output) -> Bool) -> Parsers.Filter<Self, Output> {
        .init(parser: self, preicate: preicate)
    }
    
}

extension Parsers {
    
    public struct Filter<SomeParser, Output>: Parser where SomeParser: Parser {
        
        private let parser: SomeParser
        private let preicate: (SomeParser.Output) -> Bool
        
        public init(parser: SomeParser, preicate: @escaping (SomeParser.Output) -> Bool) {
            self.parser = parser
            self.preicate = preicate
        }
        
        public func parse(_ input: SomeParser.Input) -> Result<SomeParser.Output, SomeParser.Input> {
            switch parser.parse(input) {
            case .success(let value, let remainder):
                return preicate(value) ? .success(value, remainder) : .failure("The condition is not met", input)
            case .failure(let cause, let remainder):
                return .failure(cause, remainder)
            }
        }
        
    }
    
}
