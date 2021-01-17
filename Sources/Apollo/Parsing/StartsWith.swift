public struct StartsWith<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
    
    public let count: Int
    public let possiblePrefix: AnyCollection<Input.Element>
    public let startsWith: (Input) -> Bool
    
    public init<PossiblePrefix>(_ possiblePrefix: PossiblePrefix, by areEquivalent: @escaping (Input.Element, Input.Element) -> Bool)
    where PossiblePrefix: Collection, PossiblePrefix.Element == Input.Element {
        self.count = possiblePrefix.count
        self.possiblePrefix = AnyCollection(possiblePrefix)
        self.startsWith = { input in input.starts(with: possiblePrefix, by: areEquivalent) }
    }
    
    public func parse(_ input: Input) -> Result<Input, Input> {
        guard startsWith(input) else {
            return .failure("Invalid start", input)
        }
        return .success(input.prefix(count), input.dropFirst(count))
    }
    
}

extension StartsWith where Input.Element: Equatable {
    
    public init<PossiblePrefix>(_ possiblePrefix: PossiblePrefix) where PossiblePrefix: Collection, PossiblePrefix.Element == Input.Element {
        self.init(possiblePrefix, by: ==)
    }
    
}
