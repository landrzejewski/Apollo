public struct Remainder<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
    
    public typealias Output = Input
    
    public func parse(_ input: Input) -> Result<Input, Input> {
        .success(input, input[input.endIndex...])
    }
    
}
