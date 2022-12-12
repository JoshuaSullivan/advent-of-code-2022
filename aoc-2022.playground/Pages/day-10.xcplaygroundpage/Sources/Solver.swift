import Foundation

public struct Solver {
    public static func solve(with input: [Op]) -> Int {
        var x = 1
        var cycle = 1
        var index = 0
        var valueLog: [Int] = []
        
        repeat {
//            print("cycle", cycle)
            let op = input[index]
            for _ in 0..<op.executionTime {
                valueLog.append(x)
                cycle += 1
            }
            switch op {
            case .noop:
                break
            case .addx(let val):
                x += val
            }
            index += 1
        } while index < input.count
        
        return [20, 60, 100, 140, 180, 220]
            .map { $0 * valueLog[$0 - 1] }
            .reduce(0, +)
    }
    
    public static func solve2(with input: [Op]) -> String {
        var x = 1
        var cycle = 1
        var index = 0
        var valueLog: [Int] = []
        var pixelBuffer: [Bool] = []
        var pixelIndex = 0
        
        repeat {
//            print("cycle", cycle)
            let op = input[index]
            for _ in 0..<op.executionTime {
                valueLog.append(x)
                let pixelX = pixelIndex % 40
                let isLit = abs(pixelX - x) <= 1
                print("[\(cycle)] x: \(x), pixelX: \(pixelX)    \(isLit ? "#" : ".")")
                pixelBuffer.append(isLit)
                cycle += 1
                pixelIndex += 1
            }
            switch op {
            case .noop:
                break
            case .addx(let val):
                x += val
            }
            index += 1
        } while index < input.count
        
        return pixelBuffer
            .map { $0 ? "#" : "." }
            .joined()
    }

}


public enum Op: StringInitable {
    case noop
    case addx(Int)
    
    public var executionTime: Int {
        switch self {
        case .noop: return 1
        case .addx: return 2
        }
    }
    
    public init?(_ string: String) {
        let parts = string.split(separator: " ")
        switch parts[0] {
        case "noop":
            self = .noop
        case "addx":
            guard let val = Int(parts[1]) else {
                return nil
            }
            self = .addx(val)
        default:
            fatalError("Unexpected code: \(string)")
        }
    }
}
