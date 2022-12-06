import Foundation

public struct Solver {
    public static func solve(with input: [Scorable]) -> Int {
        input.reduce(0) { $0 + $1.score }
    }
}
