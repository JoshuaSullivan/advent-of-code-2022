import Foundation

public typealias Delta = (dx: Int, dy: Int)

public struct Solver {
    
    public static func solve(with input: [Move], knotCount: Int) -> Int {
        
        let allMoves = input.flatMap { $0.expanded }
        var knots = Array<Position>(repeating: .zero, count: knotCount)
        
        var allTails: [Position] = []
        
        for move in allMoves {
            knots[0] = knots[0].moved(move)
            knots = resolve(chain: knots)
            allTails.append(knots.last!)
//            print(knots)
        }
        
        return Set(allTails).count
    }
    
    private static func getMovement(betweenHead head: Position, tail: Position) -> Delta {
        let delta = tail.distance(to: head)
        if abs(delta.dx) > 1 || abs(delta.dy) > 1 {
            let mx = max(-1, min(1, delta.dx))
            let my = max(-1, min(1, delta.dy))
            return (dx: mx, dy: my)
        }
        return (dx: 0, dy: 0)
    }
    
    private static func resolve(chain: [Position]) -> [Position] {
        var chain = chain
        for i in 1..<chain.count {
            let delta = getMovement(betweenHead: chain[i-1], tail: chain[i])
            chain[i] = chain[i].moved(by: delta)
        }
        return chain
    }
}

public enum Direction: String {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}

public struct Move: StringInitable {
    let direction: Direction
    let distance: Int
    
    public init?(_ string: String) {
        let parts = string.split(separator: " ")
        guard
            let dir = Direction(rawValue: String(parts[0])),
            let dist = Int(parts[1])
        else {
            print("Failed to parse '\(string)' into a Move.")
            return nil
        }
        self.direction = dir
        self.distance = dist
    }
    
    public var expanded: [Direction] {
        (0..<distance).map { _ in direction }
    }
}

public struct Position: Hashable, Equatable, CustomStringConvertible {
    
    public static let zero = Position(x: 0, y: 0)
    
    let x: Int
    let y: Int
    
    public func distance(to otherPos: Position) -> Delta {
        return (dx: otherPos.x - x, dy: otherPos.y - y)
    }
    
    public func moved(_ direction: Direction)  -> Position {
        switch direction {
        case .up:
            return Position(x: x, y: y + 1)
        case .down:
            return Position(x: x, y: y - 1)
        case .left:
            return Position(x: x - 1, y: y)
        case .right:
            return Position(x: x + 1, y: y)
        }
    }
    
    public func moved(by delta: Delta) -> Position {
        Position(x: x + delta.dx, y: y + delta.dy)
    }
    
    public var description: String {
        "(\(x), \(y))"
    }
}
