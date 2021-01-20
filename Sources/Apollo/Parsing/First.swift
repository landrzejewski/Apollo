extension Parsers {
    
    public struct First<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
        
        // swiftlint:disable nesting
        public typealias Output = Input.Element
        
        public func parse(_ input: Input) -> Result<Input.Element, Input> {
            guard let firstElement = input.first else {
                return .failure("Input has no elements", input)
            }
            return .success(firstElement, input.dropFirst())
        }
        
    }
    
}

typealias First = Parsers.First<Substring, Character>
