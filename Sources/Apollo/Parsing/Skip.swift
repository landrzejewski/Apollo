extension Parser {
    
    public func skipNext<NextParser>(_ nextParser: NextParser) -> Parsers.SkipSecond<Self, NextParser> {
        .init(firstParser: self, secondParser: nextParser)
    }
    
    public func skipPrevious<PreviousParser>(_ previousParser: PreviousParser) -> Parsers.SkipFirst<Self, PreviousParser> {
        .init(firstParser: self, secondParser: previousParser)
    }
    
}

extension Parsers {
    
    public struct SkipSecond<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input {
        
        private let firstParser: FirstParser
        private let secondParser: SecondParser
        
        public init(firstParser: FirstParser, secondParser: SecondParser) {
            self.firstParser = firstParser
            self.secondParser = secondParser
        }
        
        public func parse(_ input: FirstParser.Input) -> Result<FirstParser.Output, FirstParser.Input> {
            Parsers.Zip(firstParser: firstParser, secondParser: secondParser).parse(input).map { firstResult, _ in
                firstResult
            }
        }
        
    }
    
    public struct SkipFirst<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input {
        
        private let firstParser: FirstParser
        private let secondParser: SecondParser
        
        public init(firstParser: FirstParser, secondParser: SecondParser) {
            self.firstParser = firstParser
            self.secondParser = secondParser
        }
        
        public func parse(_ input: FirstParser.Input) -> Result<SecondParser.Output, FirstParser.Input> {
            Parsers.Zip(firstParser: firstParser, secondParser: secondParser).parse(input).map { _, secondParser in
                secondParser
            }
        }
        
    }
    
}
