extension Parsers {
    
    public struct Failure<Input, Output>: Parser {
        
        public func parse(_ input: Input) -> Result<Output, Input> {
            .failure("Failure", input)
        }
        
    }
    
}
