extension Parsers {
    
    public struct Whitespace<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input, Input.Element == UTF8.CodeUnit {
        
        // swiftlint:disable nesting
        public typealias Output = Input
        
        private let space = UTF8.CodeUnit.init(ascii: " ")
        private let lineFeed = UTF8.CodeUnit.init(ascii: "\n")
        private let carriageReturn = UTF8.CodeUnit.init(ascii: "\r")
        private let tabulator = UTF8.CodeUnit.init(ascii: "\t")
        
        public func parse(_ input: Input) -> Result<Input, Input> {
            let output = input.prefix(while: { $0 == space || $0 == lineFeed || $0 == carriageReturn || $0 == tabulator })
            if output.isEmpty {
                return .failure("Whitespace characters not found", input)
            }
            return .success(output, input[output.endIndex...])
        }
        
    }
    
}

public struct Whitespace: Parser {
    
    private let parser = Parsers.Whitespace<Substring.UTF8View, UTF8.CodeUnit>()
    
    public func parse(_ input: Substring) -> Result<Substring, Substring> {
        switch parser.parse(input.utf8) {
        case .success(let value, let remainder):
            return .success(String(decoding: value, as: UTF8.self)[...], Substring(remainder))
        case .failure(let cause, _):
            return .failure(cause, input)
        }
    }
    
}
