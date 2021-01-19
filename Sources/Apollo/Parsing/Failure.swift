extension Parsers {
    
    public struct Failure<Input, Output>: Parser {
        
        private let cause: String
        
        public init(cause: String) {
            self.cause = cause
        }
        
        public func parse(_ input: Input) -> Result<Output, Input> {
            .failure(cause, input)
        }
        
    }
    
}

public typealias Failure = Parsers.Failure<Substring, Substring>
