extension Parser {
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Parsers.Map<Self, NewOutput> {
        .init(parser: self, transform: transform)
    }
    
}

extension Parsers {
    
    public struct Map<BaseParser, Output>: Parser where BaseParser: Parser {
        
        let parser: BaseParser
        let transform: (BaseParser.Output) -> Output
        
        public func parse(_ input: BaseParser.Input) -> Result<Output, BaseParser.Input> {
            return parser.parse(input).map(transform)
        }
        
    }
    
}
