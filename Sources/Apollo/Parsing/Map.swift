extension Parser {
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Parsers.Map<Self, NewOutput> {
        .init(parser: self, transform: transform)
    }
    
}

extension Parsers {
    
    public struct Map<SomeParser, Output>: Parser where SomeParser: Parser {
        
        private let parser: SomeParser
        private let transform: (SomeParser.Output) -> Output
        
        public init(parser: SomeParser, transform: @escaping (SomeParser.Output) -> Output) {
            self.parser = parser
            self.transform = transform
        }
        
        public func parse(_ input: SomeParser.Input) -> Result<Output, SomeParser.Input> {
            return parser.parse(input).map(transform)
        }
        
    }
    
}
