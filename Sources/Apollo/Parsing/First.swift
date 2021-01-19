extension Parsers {
    
    public struct First<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
        
        // swiftlint:disable nesting
        public typealias Output = Input
        
        public func parse(_ input: Input) -> Result<Input, Input> {
            let subsequence = input.prefix(1)
            guard !subsequence.isEmpty else {
                return .failure("Input has no elements", input)
            }
            return .success(subsequence, input.dropFirst())
        }
        
    }
    
}

typealias First = Parsers.First<Substring, Substring>
