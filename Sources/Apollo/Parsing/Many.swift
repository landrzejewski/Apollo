extension Parsers {
    
    public struct Many<SomeParser, Output, Separator>: Parser where SomeParser: Parser, Separator: Parser, Separator.Input == SomeParser.Input, Separator.Output == SomeParser.Output {
        
        private let parser: SomeParser
        private let separator: Separator
        private let minimum: Int
        private let maximum: Int
        
        public init(parser: SomeParser, separator: Separator, atLeast minimum: Int = 0, atMost maximum: Int = .max)
        where Output == [SomeParser.Output], Separator: Parser, Separator.Input == SomeParser.Input, Separator.Output == SomeParser.Output {
            self.parser = parser
            self.separator = separator
            self.minimum = minimum
            self.maximum = maximum
        }
        
        public func parse(_ input: SomeParser.Input) -> Result<[SomeParser.Output], SomeParser.Input> {
            var inputRemainder = input
            var results: [SomeParser.Output] = []
            while results.count < maximum, case let .success(value, remainder) = parser.parse(inputRemainder) {
                results.append(value)
                inputRemainder = remainder
                switch separator.parse(inputRemainder) {
                case .success( _, let remainder):
                    inputRemainder = remainder
                case .failure:
                    guard results.count >= minimum else {
                        return .failure("Too few elemnets", input)
                    }
                    return .success(results, inputRemainder)
                }
            }
            if results.count < minimum {
                return .failure("Too few elemnets", input)
            }
            return .success(results, inputRemainder)
        }
        
    }
    
}

typealias Many = Parsers.Many
