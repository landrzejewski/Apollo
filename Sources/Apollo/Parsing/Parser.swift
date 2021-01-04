public enum Result<Value, Remainder> {
    
    case success(Value, Remainder)
    case failure(Remainder)
    
    public func map<NewValue>(_ transform: @escaping (Value) -> NewValue) -> Result<NewValue, Remainder> {
        switch self {
        case .success(let value, let remainder):
            return .success(transform(value), remainder)
        case .failure(let remainder):
            return .failure(remainder)
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
            case .success(let parser, let remainder):
                return parser.parse(remainder)
            case .failure(let remainder):
                return .failure(remainder)
            }
        }
    }
    
}

public func success<Input, Output>(_ output: Output) -> Parser<Input, Output> {
    Parser { input in
        .success(output, input)
    }
}

public func failure<Input, Output>() -> Parser<Input, Output> {
    Parser { input in
        .failure(input)
    }
}

public func prefix(while predicate: @escaping (Character) -> Bool) -> Parser<Substring, Substring> {
    Parser { input in
        let prefix = input.prefix(while: predicate)
        if (prefix.isEmpty) {
            return .failure(input)
        }
        return .success(prefix, input[prefix.endIndex...])
    }
}


//func zip<A, B>(_ a: Parser<A>, _ b: Parser<B>) -> Parser<(A, B)> {
//    return Parser<(A, B)> { text in
//        let originalText = text
//        guard let matchA = a.parse(&text) else { return nil }
//        guard let matchB = b.parse(&text) else {
//            text = originalText
//            return nil
//        }
//        return (matchA, matchB)
//    }
//}
