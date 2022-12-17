import Foundation
import RegexBuilder

public struct Solver {
    public static func solve(with monkies: [Monkey]) -> Int {
        for _ in (0..<20) {
            for monkey in monkies {
                let result = monkey.takeTurn()
                for item in result {
                    monkies[item.target].inventory.append(item.item)
                }
            }
        }
        let inspections = monkies.map { $0.examineCount }.sorted(by: >)
        return inspections[0] * inspections[1]
    }
    
    public static func solve2(with monkies: [Monkey]) -> Int {
        let commonDivisor = monkies.reduce(1) { $0 * $1.testValue }
        for _ in (0..<10_000) {
            for monkey in monkies {
                let result = monkey.takeTurn2(commonDivisor)
                for item in result {
                    monkies[item.target].inventory.append(item.item)
                }
            }
        }
        let inspections = monkies.map { $0.examineCount }.sorted(by: >)
        return inspections[0] * inspections[1]
    }
}

public class Monkey: CustomStringConvertible {
    
    public typealias WorryModifier = (Int) -> Int
    
    public let id: Int
    public var inventory: [Int]
    private var startingInventory: [Int]
    public let worryModifier: WorryModifier
    public let testValue: Int
    public let trueTarget: Int
    public let falseTarget: Int
    public var examineCount = 0
    
    public init(id: Int,
                inventory: [Int],
                worryModifier: @escaping WorryModifier,
                testValue: Int,
                trueTarget: Int,
                falseTarget: Int
    ){
        self.id = id
        self.inventory = inventory
        self.startingInventory = inventory
        self.worryModifier = worryModifier
        self.testValue = testValue
        self.trueTarget = trueTarget
        self.falseTarget = falseTarget
    }
    
    public func takeTurn() -> [TurnResultItem] {
        let result = inventory
            .map { item in
                let value = worryModifier(item) / 3
                let target = value % testValue == 0 ? trueTarget : falseTarget
                return TurnResultItem(item: value, target: target)
            }
        examineCount += inventory.count
        inventory = []
        return result
    }
    
    public func takeTurn2(_ commonDivisor: Int) -> [TurnResultItem] {
        let result = inventory
            .map { item in
                let value = worryModifier(item) % commonDivisor
                let target = value % testValue == 0 ? trueTarget : falseTarget
                return TurnResultItem(item: value, target: target)
            }
        examineCount += inventory.count
        inventory = []
        return result
    }
    
    public func reset() {
        inventory = startingInventory
        examineCount = 0
    }
    
    public var description: String {
        "Monkey \(id): \(inventory)"
    }
}

public struct TurnResultItem {
    public let item: Int
    public let target: Int
}
