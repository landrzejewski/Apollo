extension Parsers {
    
    public struct Success<Input, Output>: Parser {
        
        private let value: Output
        
        public init(value: Output) {
            self.value = value
        }
        
        public func parse(_ input: Input) -> Result<Output, Input> {
            .success(value, input)
        }
        
    }
    
}

public typealias Success = Parsers.Success<Substring, Substring>
