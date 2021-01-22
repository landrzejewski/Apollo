extension Parsers {
    
    public struct PrefixUpTo<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
        
        // swiftlint:disable nesting
        public typealias Output = Input
        
        private let possibleMatch: Input
        private let areEquivalent: (Input.Element, Input.Element) -> Bool
        
        public init(_ possibleMatch: Input, by areEquivalent: @escaping (Input.Element, Input.Element) -> Bool) {
            self.possibleMatch = possibleMatch
            self.areEquivalent = areEquivalent
        }
        
        public func parse(_ input: Input) -> Result<Input, Input> {
            guard let first = possibleMatch.first else {
                return .failure("Prefix is empty", input)
            }
            let count = possibleMatch.count
            while let index = input.firstIndex(where: { areEquivalent(first, $0) }) {
                let match = input[index...]
                if match.count >= count, Swift.zip(match[index...], possibleMatch).allSatisfy(areEquivalent) {
                    return .success(input[..<index], input[index...])
                }
            }
            return .failure("Prefix not found", input)
        }
        
    }
    
}

extension Parsers.PrefixUpTo where Input.Element: Equatable {
    
    public init(_ possibleMatch: Input) {
        self.init(possibleMatch, by: ==)
    }
    
}

extension Parsers.PrefixUpTo where Input == Substring {
    
    public init(_ possibleMatch: String) {
        self.init(possibleMatch[...])
    }
    
}

extension Parsers.PrefixUpTo where Input == Substring.UTF8View {
    
    public init(_ possibleMatch: String.UTF8View) {
        self.init(String(possibleMatch)[...].utf8)
    }
    
}

typealias PrefixUpTo = Parsers.PrefixUpTo<Substring, Substring>
