extension Parser {
    
    public func flatMap<OtherParser>(_ transform: @escaping (Output) -> OtherParser) -> FlatMap<OtherParser, Self> {
        .init(upstream: self, transform: transform)
    }
    
}

public struct FlatMap<OtherParser, Upstream>: Parser where OtherParser: Parser, Upstream: Parser, OtherParser.Input == Upstream.Input {
    
    let upstream: Upstream
    let transform: (Upstream.Output) -> OtherParser
    
    public func parse(_ input: Upstream.Input) -> Result<OtherParser.Output, Upstream.Input> {
        switch upstream.parse(input).map(transform) {
        case .success(let parser, let remainder):
            return parser.parse(remainder).get(originalRemainder: input)
        case .failure(let cause, let remainder):
            return .failure(cause, remainder)
        }
    }
    
}
