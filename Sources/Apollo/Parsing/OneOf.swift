extension Parser {
    
    //    public func eraseToAnyParser() -> AnyParser<Input, Output, Self> {
    //        .init(upstream: self)
    //    }
    
}

public struct OneOfMany<Upstream> where Upstream: Parser {
    
    let upstream: [Upstream]
    
    public init(_ parsers: [Upstream]) {
        self.upstream = parsers
    }
    
    public init(_ parsers: Upstream...) {
        self.init(parsers)
    }
    
    public func parse(_ input: Upstream.Input) -> Result<Upstream.Output, Upstream.Input> {
        for parser in upstream {
            if case let .success(value, remaining) = parser.parse(input) {
                return .success(value, remaining)
            }
        }
        return .failure("Failed", input)
    }
    
}
