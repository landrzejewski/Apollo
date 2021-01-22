extension Parser {
    
    public func orElse<SomeParser>(_ parser: SomeParser) -> Parsers.OneOf<Self, SomeParser> {
        .init(firstParser: self, seconfParser: parser)
    }
    
}

extension Parsers {
    
    public struct OneOfMany<SomeParser, Output>: Parser where SomeParser: Parser, Output == SomeParser.Output {
        
        private let parsers: [SomeParser]
        
        public init(parsers: [SomeParser]) {
            self.parsers = parsers
        }
        
        public init(parsers: SomeParser...) {
            self.init(parsers: parsers)
        }
        
        public func parse(_ input: SomeParser.Input) -> Result<SomeParser.Output, SomeParser.Input> {
            for parser in self.parsers {
                if case let .success(value, remainder) = parser.parse(input) {
                    return .success(value, remainder)
                }
            }
            return .failure("All parsers failed", input)
        }
        
    }
    
    public struct OneOf<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input, FirstParser.Output == SecondParser.Output {
        
        private let firstParser: FirstParser
        private let seconfParser: SecondParser
        
        public init(firstParser: FirstParser, seconfParser: SecondParser) {
            self.firstParser = firstParser
            self.seconfParser = seconfParser
        }
        
        public func parse(_ input: FirstParser.Input) -> Result<FirstParser.Output, FirstParser.Input> {
            if case let .success(value, remainder) = firstParser.parse(input) {
                return .success(value, remainder)
            }
            if case let .success(value, remainder) = seconfParser.parse(input) {
                return .success(value, remainder)
            }
            return .failure("Both parsers failed", input)
        }
        
    }
    
}

typealias OneOf = Parsers.OneOfMany
