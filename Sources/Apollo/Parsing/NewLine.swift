extension Parsers {
    
    public struct NewLine<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input, Input.Element == UTF8.CodeUnit {
        
        // swiftlint:disable nesting
        public typealias Output = [Input.Element]
        
        private let lineFeed = UTF8.CodeUnit.init(ascii: "\n")
        private let carriageReturn = UTF8.CodeUnit.init(ascii: "\r")
        
        public func parse(_ input: Input) -> Result<[Input.Element], Input> {
            if input.first == lineFeed {
                return .success([lineFeed], input.dropFirst())
            } else if input.first == carriageReturn, input.dropFirst().first == lineFeed {
                return .success([carriageReturn, lineFeed], input.dropFirst(2))
            }
            return .failure("New line not found", input)
        }
        
    }
    
}

public struct NewLine: Parser {
    
    private let parser = Parsers.NewLine<Substring.UTF8View, UTF8.CodeUnit>()
    
    public func parse(_ input: Substring) -> Result<Substring, Substring> {
        switch parser.parse(input.utf8) {
        case .success(let value, let remainder):
            return .success(String(decoding: value, as: UTF8.self)[...], Substring(remainder))
        case .failure(let cause, _):
            return .failure(cause, input)
        }
    }
    
}
