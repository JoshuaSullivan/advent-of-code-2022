//: # Advent of Code 2022
//: ### Day 8: Treetop Tree House
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<Int>().parseLinesOfCharacters(fileName: "input")

let result = Solver.solve(with: input)
print("Part 1:", result)

let result2 = Solver.solve2(with: input)
print("Part 2:", result2)
