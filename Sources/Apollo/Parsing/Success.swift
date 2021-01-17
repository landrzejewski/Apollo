public struct Success<Input, Output>: Parser {
    
    let output: Output
    
    public init(with output: Output) {
        self.output = output
    }
    
    public func parse(_ input: Input) -> Result<Output, Input> {
        .success(output, input)
    }
    
}
