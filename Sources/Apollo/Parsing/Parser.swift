public enum Result<Output, Rest> {
    
    case success(Output, Rest)
    case failure
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Result<NewOutput, Rest> {
        guard case let .success(output, rest) = self else {
            return .failure
        }
        return .success(transform(output), rest)
    }
    
}

public struct Parser<Input, Output> {
    
    public let parse: (_ input: Input) -> Result<Output, Input>
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Parser<Input, NewOutput> {
        Parser<Input, NewOutput> { input in
            parse(input).map(transform)
        }
    }
    
}
