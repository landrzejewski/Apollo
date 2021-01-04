import Foundation

public protocol Parser {
    
    associatedtype Input
    associatedtype Output
    
    func parse(_ input: Input) -> (output: Output?, rest: Input)
    
}
