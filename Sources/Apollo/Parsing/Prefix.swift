public struct Prefix<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
    
    public typealias Output = Input
    
    public let maxLength: Int?
    public let minLength: Int
    public let predicate: ((Input.Element) -> Bool)?
    
    public init(minLength: Int = 0, maxLength: Int? = nil, while predicate: @escaping (Input.Element) -> Bool) {
        self.minLength = minLength
        self.maxLength = maxLength
        self.predicate = predicate
    }
    
    public init(_ length: ClosedRange<Int>, while predicate: ((Input.Element) -> Bool)? = nil) {
        self.minLength = length.lowerBound
        self.maxLength = length.upperBound
        self.predicate = predicate
    }
    
    public init(_ length: Int, while predicate: ((Input.Element) -> Bool)? = nil) {
        self.minLength = length
        self.maxLength = length
        self.predicate = predicate
    }
    
    public init(_ length: PartialRangeFrom<Int>, while predicate: ((Input.Element) -> Bool)? = nil) {
        self.minLength = length.lowerBound
        self.maxLength = nil
        self.predicate = predicate
    }
    
    public init(_ length: PartialRangeThrough<Int>, while predicate: ((Input.Element) -> Bool)? = nil) {
        self.minLength = 0
        self.maxLength = length.upperBound
        self.predicate = predicate
    }
    
    public func parse(_ input: Input) -> Result<Input, Input> {
        if input.isEmpty {
            return .failure("Prefix not found", input)
        }
        if let predicate = self.predicate {
            let prefix = input.prefix(while: predicate)
            let count = prefix.count
            guard count >= self.minLength, self.maxLength.map({ count <= $0 }) ?? true else {
                return .failure("Prefix not found", input)
            }
            return .success(prefix, input[prefix.endIndex...])
        } else {
            let prefix = self.maxLength.map(input.prefix) ?? input
            let count = prefix.count
            guard count >= self.minLength else {
                return .failure("Prefix not found", input)
            }
            return .success(prefix, input[prefix.endIndex...])
        }
    }
    
}
