public struct Success<Input, Output>: Parser {
    
    let output: Output
    
    public func parse(_ input: Input) -> Result<Output, Input> {
        .success(output, input)
    }
    
}
