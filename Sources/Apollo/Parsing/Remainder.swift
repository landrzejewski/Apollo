extension Parsers {
    
    public struct Remainder<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
        
        // swiftlint:disable nesting
        public typealias Output = Input
        
        public func parse(_ input: Input) -> Result<Input, Input> {
            .success(input, input[input.endIndex...])
        }
        
    }
    
}

typealias Remainder = Parsers.Remainder<Substring, Substring>
