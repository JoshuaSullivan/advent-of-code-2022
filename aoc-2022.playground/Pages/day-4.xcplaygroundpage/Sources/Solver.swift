import Foundation

public struct Solver {
    public static func solve(with input: [[ClosedRange<Int>]]) -> Int {
        let supersetGroups = input.filter { pair in
            let r0 = pair[0]
            let r1 = pair[1]
            
            return r0.contains(otherRange: r1) || r1.contains(otherRange: r0)
        }
        return supersetGroups.count
    }
    
    public static func solve2(with input: [[ClosedRange<Int>]]) -> Int {
        let intersectingGroups = input.filter { pair in
            return pair[0].overlaps(pair[1])
        }
        return intersectingGroups.count
    }
}



extension ClosedRange<Int>: StringInitable {
    public init?(_ string: String) {
        let bounds = string
            .split(separator: "-")
            .map { Int($0)! }
        self = bounds[0]...bounds[1]
    }
    
    public func contains(otherRange: ClosedRange<Int>) -> Bool {
        otherRange.lowerBound >= self.lowerBound && otherRange.upperBound <= upperBound
    }
}
