extension Parser {
    
    public func pipe<Downstream>(_ downstream: Downstream) -> Pipe<Self, Downstream> {
        .init(self, downstream)
    }
    
}

public struct Pipe<Upstream, Downstream>: Parser where Upstream: Parser, Downstream: Parser, Upstream.Output == Downstream.Input, Upstream.Output == Upstream.Input {
   
    let upstream: Upstream
    let downstream: Downstream
    
    init(_ upstream: Upstream, _ downstream: Downstream) {
        self.upstream = upstream
        self.downstream = downstream
    }
    
    public func parse(_ input: Upstream.Input) -> Result<Downstream.Output, Upstream.Input> {
        switch upstream.parse(input) {
        case .success(let output, _):
            return downstream.parse(output)
        case .failure(let cause, let remainder):
            return .failure(cause, remainder)
        }
    }
    
}
