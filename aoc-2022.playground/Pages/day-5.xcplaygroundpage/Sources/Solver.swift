import Foundation

public struct Solver {
    public static func solve(with crates: [[String]], moves: [Move]) -> String {
        var workingCrates = crates
        for move in moves {
            let from = move.from - 1
            let to = move.to - 1
            for _ in 0..<move.count {
                let crate = workingCrates[from].removeLast()
                workingCrates[to].append(crate)
            }
        }
        
        return workingCrates.reduce("") { output, crateStack in
            let crate = crateStack.last!
            return output + crate
        }
    }
    
    public static func solve2(with crates: [[String]], moves: [Move]) -> String {
        var workingCrates = crates
        for move in moves {
            let from = move.from - 1
            let to = move.to - 1
            let cratesToMove: [String] = workingCrates[from].suffix(move.count)
            workingCrates[from].removeLast(move.count)
            workingCrates[to].append(contentsOf: cratesToMove)
        }
        
        return workingCrates.reduce("") { output, crateStack in
            let crate = crateStack.last!
            return output + crate
        }

    }
}

public struct Move: StringInitable, CustomStringConvertible {
    
    public let count: Int
    public let from: Int
    public let to: Int
    
    public static let inputFormat = /move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/
    
    public init?(_ string: String) {
        guard
            let result = try? Move.inputFormat.wholeMatch(in: string),
            let count = Int(result.count),
            let from = Int(result.from),
            let to = Int(result.to)
        else {
            return nil
        }
        self.count = count
        self.from = from
        self.to = to
    }
    
    public var description: String {
        "move \(count) from \(from) to \(to)"
    }
}
