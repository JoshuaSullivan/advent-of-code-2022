//: # Advent of Code 2022
//: ### Day 11: Monkey in the Middle
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let test = [
    Monkey(id: 0, inventory: [79, 98], worryModifier: { $0 * 19 }, testValue: 23, trueTarget: 2, falseTarget: 3),
    Monkey(id: 1, inventory: [54, 65, 75, 74], worryModifier: { $0 + 6 }, testValue: 19, trueTarget: 2, falseTarget: 0),
    Monkey(id: 2, inventory: [79, 60, 97], worryModifier: { $0 * $0 }, testValue: 13, trueTarget: 1, falseTarget: 3),
    Monkey(id: 3, inventory: [74], worryModifier: { $0 + 3 }, testValue: 17, trueTarget: 0, falseTarget: 1)
]

let input = [
    Monkey(id: 0, inventory: [74, 73, 57, 77, 74], worryModifier: { $0 * 11 }, testValue: 19, trueTarget: 6, falseTarget: 7),
    Monkey(id: 1, inventory: [99, 77, 79], worryModifier: { $0 + 8 }, testValue: 2, trueTarget: 6, falseTarget: 0),
    Monkey(id: 2, inventory: [64, 67, 50, 96, 89, 82, 82], worryModifier: { $0 + 1 }, testValue: 3, trueTarget: 5, falseTarget: 3),
    Monkey(id: 3, inventory: [88], worryModifier: { $0 * 7 }, testValue: 17, trueTarget: 5, falseTarget: 4),
    Monkey(id: 4, inventory: [80, 66, 98, 83, 70, 63, 57, 66], worryModifier: { $0 + 4 }, testValue: 13, trueTarget: 0, falseTarget: 1),
    Monkey(id: 5, inventory: [81, 93, 90, 61, 62, 64], worryModifier: { $0 + 7 }, testValue: 7, trueTarget: 1, falseTarget: 4),
    Monkey(id: 6, inventory: [69, 97, 88, 93], worryModifier: { $0 * $0 }, testValue: 5, trueTarget: 7, falseTarget: 2),
    Monkey(id: 7, inventory: [59, 80], worryModifier: { $0 + 6 }, testValue: 11, trueTarget: 2, falseTarget: 3)
]

let result = Solver.solve(with: input)
print("Part 1:", result)

input.forEach { $0.reset() }

let result2 = Solver.solve2(with: input)
print("Part 2:", result2)
