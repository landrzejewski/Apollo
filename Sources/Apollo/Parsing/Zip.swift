extension Parser {
    
    public func zip<SecondParser>(_ secondParser: SecondParser) -> Zip<Self, SecondParser> where SecondParser: Parser, SecondParser.Input == Input {
        .init(firstParser: self, secondParser: secondParser)
    }
    
    public func zip<A, B, SecondParser>(_ secondParser: SecondParser) -> Zip3<Self, A, B, SecondParser> where SecondParser: Parser, SecondParser.Input == Input, Output == (A, B) {
        .init(firstParser: self, secondParser: secondParser)
    }
    
    public func zip<A, B, C, SecondParser>(_ secondParser: SecondParser) -> Zip4<Self, A, B, C, SecondParser> where SecondParser: Parser, SecondParser.Input == Input, Output == (A, B, C) {
        .init(firstParser: self, secondParser: secondParser)
    }
    
    public func zip<A, B, C, D, SecondParser>(_ secondParser: SecondParser) -> Zip5<Self, A, B, C, D, SecondParser> where SecondParser: Parser, SecondParser.Input == Input, Output == (A, B, C, D) {
        .init(firstParser: self, secondParser: secondParser)
    }
    
}

public struct Zip<FirstParser, SecondParser>: Parser where FirstParser: Parser, SecondParser: Parser, FirstParser.Input == SecondParser.Input {
    
    let firstParser: FirstParser
    let secondParser: SecondParser
    
    public func parse(_ input: FirstParser.Input) -> Result<(FirstParser.Output, SecondParser.Output), FirstParser.Input> {
        switch firstParser.parse(input) {
        case .success(let output, let remainder):
            return secondParser.parse(remainder).combine(with: output, originalRemainder: input)
        case .failure(let cause, let remainder):
            return .failure(cause, remainder)
        }
    }
    
}

public struct Zip3<FirstParser, A, B, SecondParser>: Parser where FirstParser: Parser, FirstParser.Output == (A, B), SecondParser: Parser, FirstParser.Input == SecondParser.Input {
    
    public let firstParser: FirstParser
    public let secondParser: SecondParser
    
    public func parse(_ input: FirstParser.Input) -> Result<(A, B, SecondParser.Output), FirstParser.Input> {
        Zip(firstParser: firstParser, secondParser: secondParser).parse(input).map { tuple, result in
            (tuple.0, tuple.1, result)
        }
    }
    
}

public struct Zip4<FirstParser, A, B, C, SecondParser>: Parser where FirstParser: Parser, FirstParser.Output == (A, B, C), SecondParser: Parser, FirstParser.Input == SecondParser.Input {
    
    public let firstParser: FirstParser
    public let secondParser: SecondParser
    
    public func parse(_ input: FirstParser.Input) -> Result<(A, B, C, SecondParser.Output), FirstParser.Input> {
        Zip(firstParser: firstParser, secondParser: secondParser).parse(input).map { tuple, result in
            (tuple.0, tuple.1, tuple.2, result)
        }
    }
    
}

public struct Zip5<FirstParser, A, B, C, D, SecondParser>: Parser where FirstParser: Parser, FirstParser.Output == (A, B, C, D), SecondParser: Parser, FirstParser.Input == SecondParser.Input {
    
    public let firstParser: FirstParser
    public let secondParser: SecondParser
    
    public func parse(_ input: FirstParser.Input) -> Result<(A, B, C, D, SecondParser.Output), FirstParser.Input> {
        Zip(firstParser: firstParser, secondParser: secondParser).parse(input).map { tuple, result in
            (tuple.0, tuple.1, tuple.2, tuple.3, result)
        }
    }
    
}
