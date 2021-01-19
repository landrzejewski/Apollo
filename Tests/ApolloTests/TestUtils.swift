@testable import Apollo

let testInput = "Sample text"[...]
let testValue = "Sample value"[...]
let testCause = "Test failure"
let emptyText = ""[...]

struct SuccessStub: Parser {
    
    private let value: Substring
    
    init(value: Substring) {
        self.value = value
    }
    
    func parse(_ input: Substring) -> Result<Substring, Substring> {
        .success(value, input)
    }
    
}

struct FailureStub: Parser {
    
    private let cause: String
    
    init(cause: String) {
        self.cause = cause
    }
    
    func parse(_ input: Substring) -> Result<Substring, Substring> {
        .failure(cause, input)
    }
    
}
