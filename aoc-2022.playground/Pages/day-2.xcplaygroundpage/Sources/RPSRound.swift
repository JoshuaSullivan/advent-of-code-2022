import Foundation

public protocol Scorable {
    var score: Int { get }
}

public enum Move: Equatable {
    case rock
    case paper
    case scissors
    
    public var value: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }
    
    public func result(versus otherMove: Move) -> Result {
        switch (self, otherMove) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return .win
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return .draw
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            return .loss
        }
    }
}

public enum Result {
    case win
    case draw
    case loss
    
    var value: Int {
        switch self {
        case .win: return 6
        case .draw: return 3
        case .loss: return 0
        }
    }
}

public struct RPSRound: StringInitable, Scorable {
    
    public let opponent: Move
    public let player: Move
    
    public init?(_ string: String) {
        let parts = string.split(separator: " ")
        switch parts[0] {
        case "A": opponent = .rock
        case "B": opponent = .paper
        case "C": opponent = .scissors
        default: fatalError("Unexpected opponent move value.")
        }
        
        switch parts[1] {
        case "X": player = .rock
        case "Y": player = .paper
        case "Z": player = .scissors
        default: fatalError("Unexpected player move value.")
        }
    }
    
    public var score: Int {
        player.value + player.result(versus: opponent).value
    }
}

public struct RPSRoundAlt: StringInitable, Scorable {
    
    public let opponent: Move
    public let player: Move
    
    public init?(_ string: String) {
        let parts = string.split(separator: " ")
        switch parts[0] {
        case "A": opponent = .rock
        case "B": opponent = .paper
        case "C": opponent = .scissors
        default: fatalError("Unexpected opponent move value.")
        }
        
        switch parts[1] {
        case "X":
            switch opponent {
            case .rock:
                player = .scissors
            case .paper:
                player = .rock
            case .scissors:
                player = .paper
            }
        case "Y":
            player = opponent
        case "Z":
            switch opponent {
            case .rock:
                player = .paper
            case .paper:
                player = .scissors
            case .scissors:
                player = .rock
            }
        default: fatalError("Unexpected player move value.")
        }
    }
    
    public var score: Int {
        player.value + player.result(versus: opponent).value
    }
}
