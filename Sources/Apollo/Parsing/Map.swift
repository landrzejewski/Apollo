extension Parser {
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Parsers.Map<Self, NewOutput> {
        .init(upstream: self, transform: transform)
    }
    
}

extension Parsers {
    
    public struct Map<Upstream, Output>: Parser where Upstream: Parser {
        
        let upstream: Upstream
        let transform: (Upstream.Output) -> Output
        
        public func parse(_ input: Upstream.Input) -> Result<Output, Upstream.Input> {
            return upstream.parse(input).map(transform)
        }
        
    }
    
}
