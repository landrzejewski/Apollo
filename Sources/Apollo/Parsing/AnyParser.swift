extension Parser {
    
    public func eraseToAnyParser() -> AnyParser<Input, Output, Self> {
        .init(upstream: self)
    }
    
}

public struct AnyParser<Input, Output, Other> where Other: Parser, Other.Input == Input, Other.Output == Output {
    
    let upstream: Other
   
    public func parse(_ input: Input) -> Result<Output, Input> {
        upstream.parse(input)
    }
    
    public func eraseToAnyParser() -> Self {
      self
    }
    
}
