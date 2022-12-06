import Foundation

public struct Solver {
    
    private static let priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    public static func solve(with input: [String]) -> Int {
        let dupes = input.map { line in
            let fh = line.firstHalf
            let lh = line.lastHalf
            return fh.first(where: { lh.contains($0) })!
        }
        let priorityValues: [Int] = dupes.map { self.priorityValue(of: $0) }
        return priorityValues.reduce(0, +)
    }
    
    public static func solve2(with input: [String]) -> Int {
        
        let groups = input.chunks(ofCount: 3)
        let ids = groups.map { group in
            return priorities.first(where: { char in
                group.allSatisfy { $0.contains(char) }
            })!
        }
        let values = ids.map { self.priorityValue(of: $0) }
        return values.reduce(0, +)
    }
    
    private static func priorityValue(of char: Character) -> Int {
        guard let index = priorities.firstIndex(of: char) else {
            fatalError("Could not find character in priority list.")
        }
        return priorities.distance(from: priorities.startIndex, to: index) + 1
    }
}

extension String {
    var firstHalf: String {
        String(prefix(self.count / 2))
    }
    
    var lastHalf: String {
        String(suffix(self.count / 2))
    }
}
