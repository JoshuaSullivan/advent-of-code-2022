//: # Advent of Code 2022
//: ### Day 7: No Space Left On Device
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<String>().parseLines(fileName: "input")

let result = Solver.solve(with: input)
print("Part 1:", result)

let result2 = Solver.solve2(with: input)
print("Part 2:", result2)
