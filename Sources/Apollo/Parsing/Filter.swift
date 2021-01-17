extension Parser {
    
    public func filter(_ preicate: @escaping (Output) -> Bool) -> Filter<Self, Output> {
        .init(upstream: self, preicate: preicate)
    }
    
}

public struct Filter<Upstream, Output>: Parser where Upstream: Parser {
    
    let upstream: Upstream
    let preicate: (Upstream.Output) -> Bool
    
    public func parse(_ input: Upstream.Input) -> Result<Upstream.Output, Upstream.Input> {
        switch upstream.parse(input) {
        case .success(let value, let remainder):
            return preicate(value) ? .success(value, remainder) : .failure("Precondition failed", input)
        case .failure(let cause, let remainder):
            return .failure(cause, remainder)
        }
    }
    
}
