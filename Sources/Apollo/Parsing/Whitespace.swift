public struct Whitespace<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input, Input.Element == UTF8.CodeUnit {
   
    public typealias Output = Input
    
    public init() {
    }
    
    public func parse(_ input: Input) -> Result<Input, Input> {
        let output = input.prefix(while: { (byte: UTF8.CodeUnit) in
            byte == .init(ascii: " ")
                || byte == .init(ascii: "\n")
                || byte == .init(ascii: "\r")
                || byte == .init(ascii: "\t")
        })
        return .success(output, input[output.endIndex...])
    }
    
}
