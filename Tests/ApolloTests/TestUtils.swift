@testable import Apollo

let testFailureCause = "Test failure"
let emptySequence = ""[...]

struct SuccessStub: Parser {
    
    let value: Substring
    
    func parse(_ input: Substring) -> Result<Substring, Substring> {
        return .success(value.prefix(1), input.dropFirst())
    }
    
}

struct FailureStub: Parser {
    
    let cause: String
    
    init(cause: String) {
        self.cause = cause
    }
    
    func parse(_ input: Substring) -> Result<Substring, Substring> {
        .failure(cause, input)
    }
    
}
