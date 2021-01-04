public func prefix(while predicate: @escaping (Character) -> Bool) -> Parser<Substring, Substring> {
    Parser { input in
        let prefix = input.prefix(while: predicate)
        if (prefix.isEmpty) {
            return .failure
        }
        return .success(prefix, input[prefix.endIndex...])
    }
}
