public struct Prefix: Parser {
    
    private let predicate: ((Character) -> Bool)
    
    public init(while predicate: @escaping (Character) -> Bool) {
        self.predicate = predicate
    }
    
    public func parse(_ input: Substring) -> (output: Substring?, rest: Substring) {
        let prefix = input.prefix(while: predicate)
        if (prefix.isEmpty) {
            return (nil, input)
        }
        return (prefix, input[prefix.endIndex...])
    }
    
}
