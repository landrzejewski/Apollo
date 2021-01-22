extension Parsers {
    
    public struct StartsWith<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
        
        private let count: Int
        private let prefix: AnyCollection<Input.Element>
        private let startsWith: (Input) -> Bool
        
        public init<Prefix>(prefix: Prefix, by areEquivalent: @escaping (Input.Element, Input.Element) -> Bool)
        where Prefix: Collection, Prefix.Element == Input.Element {
            self.count = prefix.count
            self.prefix = AnyCollection(prefix)
            self.startsWith = { input in input.starts(with: prefix, by: areEquivalent) }
        }
        
        public func parse(_ input: Input) -> Result<Input, Input> {
            guard startsWith(input) else {
                return .failure("Prefix not found", input)
            }
            return .success(input.prefix(count), input.dropFirst(count))
        }
        
    }
    
}

extension Parsers.StartsWith where Input.Element: Equatable {
    
    public init<Prefix>(prefix: Prefix) where Prefix: Collection, Prefix.Element == Input.Element {
        self.init(prefix: prefix, by: ==)
    }
    
}

public struct StartsWith: Parser {
    
    private let parser: Parsers.StartsWith<Substring, Substring>
    
    public init(prefix: Substring) {
        parser = Parsers.StartsWith(prefix: prefix) { $0 == $1 }
    }
    
    public func parse(_ input: Substring) -> Result<Substring, Substring> {
        parser.parse(input)
    }
    
}
