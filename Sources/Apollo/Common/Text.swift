extension String {
    
    subscript (offsetValue: Int) -> Character {
        return self[index(startIndex, offsetBy: offsetValue)]
    }
    
}

func levenshteinDistance(firstWord: String, secondWord: String) -> Int? {
    if firstWord.isEmpty {
        return secondWord.count
    }
    if secondWord.isEmpty {
        return firstWord.count
    }
    var distanceMatrix = Array(repeating: Array(repeating: 0, count: secondWord.count + 1), count: firstWord.count + 1)
    for index in 1...(firstWord.count) {
        distanceMatrix[index][0] = index
    }
    for index in 1...(secondWord.count) {
        distanceMatrix[0][index] = index
    }
    for column in 1...(firstWord.count) {
        for row in 1...(secondWord.count) {
            let addCost = distanceMatrix[column][row - 1] + 1
            let removeCost = distanceMatrix[column - 1][row] + 1
            let changeCost = ((firstWord[column - 1] == secondWord[row - 1]) ? 0 : 1) + distanceMatrix[column - 1][row - 1]
            distanceMatrix[column][row] = min(addCost, removeCost, changeCost)
        }
    }
    return distanceMatrix.last?.last
}
