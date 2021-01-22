extension Parser {
    
    public func pipe<SecondParser>(_ secondParser: SecondParser) -> Parsers.Pipe<Self, SecondParser> {
        .init(self, secondParser)
    }
    
}

extension Parsers {
    
    public struct Pipe<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Output == SecondParser.Input, FirstParser.Output == FirstParser.Input {
        
        let firstParser: FirstParser
        let secondParser: SecondParser
        
        init(_ firstParser: FirstParser, _ secondParser: SecondParser) {
            self.firstParser = firstParser
            self.secondParser = secondParser
        }
        
        public func parse(_ input: FirstParser.Input) -> Result<SecondParser.Output, FirstParser.Input> {
            switch firstParser.parse(input) {
            case .success(let output, _):
                return secondParser.parse(output)
            case .failure(let cause, let remainder):
                return .failure(cause, remainder)
            }
        }
        
    }
    
}
