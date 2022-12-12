//: # Advent of Code 2022
//: ### Day 10: Cathode-Ray Tube
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<Op>().parseLines(fileName: "input")

let result = Solver.solve(with: input)
print("Part 1:", result)

let result2 = Solver.solve2(with: input)
let format = result2.chunks(ofCount: 40).joined(separator: "\n")
print("Part 2:\n\(format)")
