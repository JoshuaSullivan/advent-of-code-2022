import Foundation

public struct Solver {
    public static func solve(with input: [[Int]]) -> Int? {
        input
            .map({ $0.reduce(0, +) })
            .max()
    }
    
    public static func solve2(with input: [[Int]]) -> Int? {
        guard input.count >= 3 else {
            fatalError("Not enough items in the input.")
        }
        
        return input
            .map({ $0.reduce(0, +) })
            .sorted()
            .suffix(3)
            .reduce(0, +)
    }
}
