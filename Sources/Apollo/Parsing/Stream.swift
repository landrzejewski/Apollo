extension Parser where Input: RangeReplaceableCollection {
    
    public var stream: Stream<Self, Output> {
        .init(upstream: self)
    }
    
}

public struct Stream<Upstream, Output>: Parser where Upstream: Parser, Upstream.Input: RangeReplaceableCollection {
    
    public let upstream: Upstream
    
    public init(upstream: Upstream) {
        self.upstream = upstream
    }
    
    public func parse(_ input: AnyIterator<Upstream.Input>) -> Result<[Upstream.Output], AnyIterator<Upstream.Input>> {
        var buffer = Upstream.Input()
        var outputs: [Upstream.Output] = []
        while let chunk = input.next() {
            buffer.append(contentsOf: chunk)
            while case let .success(value, _) = upstream.parse(buffer) {
                outputs.append(value)
            }
        }
        return .success(outputs, input)
    }
    
}
