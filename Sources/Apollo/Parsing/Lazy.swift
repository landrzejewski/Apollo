public final class Lazy<SomeParser, Output>: Parser where SomeParser: Parser {
    
    private let parserFactory: () -> SomeParser
    
    private var parser: SomeParser?
    
    public init(parserFactory: @escaping () -> SomeParser) {
        self.parserFactory = parserFactory
    }
    
    public func parse(_ input: SomeParser.Input) -> Result<SomeParser.Output, SomeParser.Input> {
        guard let lazyParser = parser else {
            parser = parserFactory()
            return parser!.parse(input)
        }
        return lazyParser.parse(input)
    }

}
