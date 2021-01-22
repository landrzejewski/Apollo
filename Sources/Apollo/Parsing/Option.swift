extension Parsers {
    
    public enum Option<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input, FirstParser.Output == SecondParser.Output {
        
        case first(FirstParser)
        case second(SecondParser)
        
        public func parse(_ input: FirstParser.Input) -> Result<FirstParser.Output, FirstParser.Input> {
            switch self {
            case let .first(first):
                return first.parse(input)
            case let .second(second):
                return second.parse(input)
            }
        }
        
    }
    
}

typealias Option = Parsers.Option
