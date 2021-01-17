public struct First<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
    
    public typealias Output = Input.Element
    
    public init() {
    }
    
    public func parse(_ input: Input) -> Result<Input.Element, Input> {
        guard let first = input.first else {
            return .failure("Empty", input)
        }
        return .success(first, input.dropFirst())
    }
    
}
