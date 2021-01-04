public enum Result<Output, Rest> {
    
    case success(Output, Rest)
    case failure(Rest)
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Result<NewOutput, Rest> {
        switch self {
        case .success(let output, let rest):
            return .success(transform(output), rest)
        case .failure(let rest):
            return .failure(rest)
        }
    }
    
}

public struct Parser<Input, Output> {
    
    public let parse: (_ input: Input) -> Result<Output, Input>
    
    public func map<NewOutput>(_ transform: @escaping (Output) -> NewOutput) -> Parser<Input, NewOutput> {
        Parser<Input, NewOutput> { input in
            parse(input).map(transform)
        }
    }
    
    public func flatMap<NewOutput>(_ transform: @escaping (Output) -> Parser<Output, NewOutput>) -> Parser<Output, NewOutput>  where Input == Output {
        Parser<Input, NewOutput> { input in
            switch parse(input).map(transform) {
            case .success(let output, let rest):
                return output.parse(rest)
            case .failure(let rest):
                return .failure(rest)
            }
        }
    }
    
}

func success<Input, Output>(_ output: Output) -> Parser<Input, Output> {
    Parser { input in
        .success(output, input)
    }
}

func failure<Input, Output>() -> Parser<Input, Output> {
    Parser { input in
        .failure(input)
    }
}
