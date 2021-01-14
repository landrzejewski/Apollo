public struct End<Input, Output>: Parser where Input: Collection {
    
    public typealias Output = Input
    
    public func parse(_ input: Input) -> Result<Input, Input> {
        input.isEmpty ? .success(input, input) : .failure("Input is not empty", input)
    }
    
}
