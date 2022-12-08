import Foundation

public struct Solver {
    
    public static func solve(with input: [[Int]]) -> Int {
        let forest = input.map { $0.map { Tree(height: $0) } }
        let w = forest[0].count
        for row in forest {
            row[0].isVisible = true
            row[row.count - 1].isVisible = true
            // From the left
            var maxHeight = -1
            for tree in row {
                if tree.height > maxHeight {
                    tree.isVisible = true
                    maxHeight = tree.height
                }
            }
            // From the right
            maxHeight = -1
            for tree in row.reversed() {
                if tree.height > maxHeight {
                    tree.isVisible = true
                    maxHeight = tree.height
                }
            }
        }
        
        let columns = (0..<w).map { forest[column: $0] }
        for col in columns {
            // From the top.
            var maxHeight = -1
            for tree in col {
                if tree.height > maxHeight {
                    tree.isVisible = true
                    maxHeight = tree.height
                }
            }
            
            // From the bottom.
            maxHeight = -1
            for tree in col.reversed() {
                if tree.height > maxHeight {
                    tree.isVisible = true
                    maxHeight = tree.height
                }
            }
        }
        
        return forest.reduce(0) {
            $0 + $1.filter { $0.isVisible }.count
        }
    }
    
    public static func solve2(with input: [[Int]]) -> Int {
        let forest = input.map { $0.map { Tree(height: $0) } }
        let w = forest[0].count
        let h = forest.count
        for x in 1..<(w-1) {
            for y in 1..<(h - 1) {
//                print("Checking tree at (\(x), \(y)):")
                let tree = forest[y][x]
                let pos = Position(x: x, y: y)
                for dir in Direction.allCases {
                    let dist = scan(start: pos, dir: dir, forest: forest)
//                    print("\t\(dir): \(dist)")
                    tree.viewDistance[dir] = dist
                }
//                print("\tSCORE: \(tree.scenicScore)")
            }
        }
        return forest
            .flatMap { $0 }
            .map { $0.scenicScore }
            .max()!
    }
    
    private static func scan(start: Position, dir: Direction, forest: [[Tree]]) -> Int {
        let w = forest[0].count
        let h = forest.count
        let bounds = Size(width: w, height: h)
        
        let startTree = forest[start.y][start.x]
        var pos = start.applying(dir)
        repeat {
            let tree = forest[pos.y][pos.x]
            guard tree.height < startTree.height else {
                return pos.distance(to: start)
            }
            pos = pos.applying(dir)
        } while (bounds.contains(pos))
        return pos.distance(to: start) - 1
    }
}

public class Tree: CustomStringConvertible {
    public let height: Int
    public var isVisible = false
    public var viewDistance: [Direction : Int] = [:]
    
    public init(height: Int) {
        self.height = height
    }
    
    public var scenicScore: Int {
        let scores = viewDistance.values
        guard scores.count == 4 else { return 0 }
        return scores.reduce(1, *)
    }
    
    public var description: String {
        "[\(height)\(isVisible ? "T" : "F")]"
    }
}

public enum Direction: Hashable, CaseIterable {
    case up, down, left, right
    
    public var offset: (Int, Int) {
        switch self {
        case .up: return (0, -1)
        case .down: return (0, 1)
        case .left: return (-1, 0)
        case .right: return (1, 0)
        }
    }
}

public struct Position {
    public let x: Int
    public let y: Int
    
    public func applying(_ direction: Direction) -> Position {
        let offset = direction.offset
        return Position(x: x + offset.0, y: y + offset.1)
    }
    
    public func distance(to otherPos: Position) -> Int {
        return abs(x - otherPos.x) + abs(y - otherPos.y)
    }
}

public struct Size {
    public let width: Int
    public let height: Int
    
    public func contains(_ position: Position) -> Bool {
        position.x >= 0 && position.y >= 0 && position.x < width && position.y < height
    }
}


extension Array where Element : Collection {
    subscript(column column : Element.Index) -> [ Element.Iterator.Element ] {
        return map { $0[ column ] }
    }
}
