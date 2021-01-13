extension Parser {
    
    public func flatMap<Downstrem>(_ transform: @escaping (Output) -> Downstrem) -> Parsers.FlatMap<Downstrem, Self> {
        .init(upstream: self, transform: transform)
    }
    
}

extension Parsers {
    
    public struct FlatMap<Downstrem, Upstream>: Parser where Downstrem: Parser, Upstream: Parser, Downstrem.Input == Upstream.Input {
        
        let upstream: Upstream
        let transform: (Upstream.Output) -> Downstrem
        
        public func parse(_ input: Upstream.Input) -> Result<Downstrem.Output, Upstream.Input> {
            switch upstream.parse(input).map(transform) {
            case .success(let parser, let remainder):
                return parser.parse(remainder).get(originalRemainder: input)
            case .failure(let cause, let remainder):
                return .failure(cause, remainder)
            }
        }
        
    }
    
}
