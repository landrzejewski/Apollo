public struct Failure<Input, Output>: Parser {
    
    let cause: String
    
    public init(causedBy cause: String) {
        self.cause = cause
    }
    
    public func parse(_ input: Input) -> Result<Output, Input> {
        .failure(cause, input)
    }
    
}
