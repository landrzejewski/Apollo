extension Parsers {
    
    public struct Prefix<Input, Output>: Parser where Input: Collection, Input.SubSequence == Input {
        
        // swiftlint:disable nesting
        public typealias Output = Input
        
        private let minLength: Int
        private let maxLength: Int?
        private let predicate: ((Input.Element) -> Bool)?
        
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
                guard count >= minLength, maxLength.map({ count <= $0 }) ?? true else {
                    return .failure("Prefix not found", input)
                }
                return .success(prefix, input[prefix.endIndex...])
            } else {
                let prefix = maxLength.map(input.prefix) ?? input
                guard prefix.count >= minLength else {
                    return .failure("Prefix not found", input)
                }
                return .success(prefix, input[prefix.endIndex...])
            }
        }
        
    }
    
}

typealias Prefix = Parsers.Prefix<Substring, Substring>
