public enum Result<Value, Remainder> {

    case success(Value, Remainder)
    case failure(String, Remainder)
    
    public func map<OtherValue>(_ transform: @escaping (Value) -> OtherValue) -> Result<OtherValue, Remainder> {
        switch self {
        case .success(let value, let remainder):
            return .success(transform(value), remainder)
        case .failure(let cause, let remainder):
            return .failure(cause, remainder)
        }
    }
    
    public func get(originalRemainder: Remainder) -> Result<Value, Remainder> {
        if case let .failure(cause, _) = self {
            return .failure(cause, originalRemainder)
        }
        return self
    }
    
    public func combine<OtherValue>(with otherValue: OtherValue, originalRemainder: Remainder) -> Result<(OtherValue, Value), Remainder> {
        switch self {
        case .success(let value, let remainder):
            return .success((otherValue, value), remainder)
        case .failure(let cause, _):
            return .failure(cause, originalRemainder)
        }
    }

}

extension Result: Equatable where Value: Equatable, Remainder: Equatable {
    
}
