// Or praresr

public enum Option<First, Second>: Parser where First: Parser, Second: Parser, First.Input == Second.Input, First.Output == Second.Output {
    
    case first(First)
    case second(Second)

    public func parse(_ input: First.Input) -> Result<First.Output, First.Input> {
      switch self {
      case let .first(first):
        return first.parse(input)
      case let .second(second):
        return second.parse(input)
      }
    }
    
}
