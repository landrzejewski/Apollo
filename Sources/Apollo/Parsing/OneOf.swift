extension Parser {
    
    public func orElse<P>(_ parser: P) -> OneOf<Self, P> {
        .init(self, parser)
    }
    
}

public struct OneOfMany<Upstream, Output>: Parser where Upstream: Parser {
    
    public let parsers: [Upstream]
    
    public init(_ parsers: [Upstream]) {
        self.parsers = parsers
    }
    
    public init(_ parsers: Upstream...) {
        self.init(parsers)
    }
    
    public func parse(_ input: Upstream.Input) -> Result<Upstream.Output, Upstream.Input> {
        for parser in self.parsers {
            if case let .success(value, remainder) = parser.parse(input) {
                return .success(value, remainder)
            }
        }
        return .failure("Failure", input)
    }
    
}

public struct OneOf<A, B>: Parser where A: Parser, B: Parser, A.Input == B.Input, A.Output == B.Output {
    
    public let firstParser: A
    public let seconfParser: B
    
    public init(_ firstParser: A, _ seconfParser: B) {
        self.firstParser = firstParser
        self.seconfParser = seconfParser
    }
    
    public func parse(_ input: A.Input) -> Result<A.Output, A.Input> {
        if case let .success(value, remainder) = firstParser.parse(input) {
            return .success(value, remainder)
        }
        if case let .success(value, remainder) = seconfParser.parse(input) {
            return .success(value, remainder)
        }
        return .failure("Failure", input)
    }
    
}
