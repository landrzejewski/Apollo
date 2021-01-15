extension Parser {
    
    public func skip<SecondParser>(_ secondParser: SecondParser) -> Skip<Self, SecondParser> {
        .init(self, secondParser)
    }
    
    public func skipPrevious<SecondParser>(_ secondParser: SecondParser) -> SkipFirst<Self, SecondParser> {
        .init(self, secondParser)
    }

}

public struct Skip<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input {
    
    let firstParser: FirstParser
    let secondParser: SecondParser
    
    init(_ firstParser: FirstParser, _ secondParser: SecondParser) {
        self.firstParser = firstParser
        self.secondParser = secondParser
    }
    
    public func parse(_ input: FirstParser.Input) -> Result<FirstParser.Output, FirstParser.Input> {
        Zip(firstParser, secondParser).parse(input).map { firstResult, _ in
            firstResult
        }
    }
    
}

public struct SkipFirst<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input {
    
    let firstParser: FirstParser
    let secondParser: SecondParser
    
    init(_ firstParser: FirstParser, _ secondParser: SecondParser) {
        self.firstParser = firstParser
        self.secondParser = secondParser
    }
    
    public func parse(_ input: FirstParser.Input) -> Result<SecondParser.Output, FirstParser.Input> {
        Zip(firstParser, secondParser).parse(input).map { _, secondParser in
            secondParser
        }
    }
    
}
