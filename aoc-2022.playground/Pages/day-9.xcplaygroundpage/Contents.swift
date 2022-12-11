//: # Advent of Code 2022
//: ### Day 9: Rope Bridge
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<Move>().parseLines(fileName: "input")

let result = Solver.solve(with: input, knotCount: 2)
print("Part 1:", result)

let result2 = Solver.solve(with: input, knotCount: 10)
print("Part 2:", result2)
