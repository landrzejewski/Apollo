public struct NewLine<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input, Input.Element == UTF8.CodeUnit {
   
    public typealias Output = [Input.Element]
    
    public init() {
    }
    
    public func parse(_ input: Input) -> Result<[Input.Element], Input> {
        if input.first == .init(ascii: "\n") {
            return .success([.init(ascii: "\n")], input.dropFirst())
        } else if input.first == .init(ascii: "\r"), input.dropFirst().first == .init(ascii: "\n") {
            return .success([.init(ascii: "\r"), .init(ascii: "\n")], input.dropFirst(2))
        }
        return .failure("", input)
    }
    
}
