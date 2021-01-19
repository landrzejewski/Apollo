public struct Many<Upstream, Output, Results, Separator>: Parser where Upstream: Parser, Separator: Parser, Upstream.Input == Separator.Input {
    
    public let initialResult: Results
    public let maximum: Int
    public let minimum: Int
    public let separator: Separator?
    public let updateAccumulatingResult: (inout Results, Upstream.Output) -> Void
    public let upstream: Upstream
    
    public init(_ upstream: Upstream, into initialResult: Results, atLeast minimum: Int = 0, atMost maximum: Int = .max, separator: Separator,
                _ updateAccumulatingResult: @escaping (inout Results, Upstream.Output) -> Void) {
        self.initialResult = initialResult
        self.maximum = maximum
        self.minimum = minimum
        self.separator = separator
        self.updateAccumulatingResult = updateAccumulatingResult
        self.upstream = upstream
    }
    
    public func parse(_ input: Upstream.Input) -> Result<Results, Upstream.Input> {
        var rest = input
        var result = initialResult
        var count = 0
        
        while count < maximum, case let .success(value, remainder) = upstream.parse(rest) {
            count += 1
            rest = remainder
            updateAccumulatingResult(&result, value)
            if let separator = separator {
                switch separator.parse(remainder) {
                case .success( _, let remainder):
                   rest = remainder
                case .failure(let cause, let remainder):
                    guard count >= minimum else {
                        return .failure(cause, input)
                        
                    }
                    return  .success(result, remainder)
                }

            }
        }
        guard count >= minimum else {
            return .failure("Failure", input)
        }
        return .success(result, rest)
    }
    
}

extension Many where Results == [Upstream.Output], Separator == Parsers.Success<Input, Void> {

    public init(_ upstream: Upstream, atLeast minimum: Int = 0, atMost maximum: Int = .max) {
        self.init(upstream, into: [], atLeast: minimum, atMost: maximum) {
            $0.append($1)
        }
    }

}

extension Many where Results == [Upstream.Output] {

    public init(_ upstream: Upstream, atLeast minimum: Int = 0, atMost maximum: Int = .max, separator: Separator) {
        self.init(upstream, into: [], atLeast: minimum, atMost: maximum, separator: separator) {
            $0.append($1)
        }
    }

}

extension Many where Separator == Parsers.Success<Input, Void> {

    public init(_ upstream: Upstream, into initialResult: Results, atLeast minimum: Int = 0, atMost maximum: Int = .max,
                _ updateAccumulatingResult: @escaping ( inout Results, Upstream.Output) -> Void) {
        self.initialResult = initialResult
        self.maximum = maximum
        self.minimum = minimum
        self.separator = nil
        self.updateAccumulatingResult = updateAccumulatingResult
        self.upstream = upstream
    }

}
