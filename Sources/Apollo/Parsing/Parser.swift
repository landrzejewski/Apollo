public protocol Parser {
    
    associatedtype Input
    associatedtype Output
    
    func parse(_ input: Input) -> Result<Output, Input>
    
}
