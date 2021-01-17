@testable import Apollo

let emptyText = ""[...]

struct SuccessStub<Input, Output>: Parser {
    
    let output: Output
    
    init(with output: Output) {
        self.output = output
    }
    
    public func parse(_ input: Input) -> Result<Output, Input> {
        .success(output, input)
    }
    
}

struct FailureStub<Input, Output>: Parser {
    
    let cause = "Test failure"
    
    public func parse(_ input: Input) -> Result<Output, Input> {
        .failure(cause, input)
    }
    
}
