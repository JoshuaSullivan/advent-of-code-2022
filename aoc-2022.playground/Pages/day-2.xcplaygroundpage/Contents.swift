//: # Advent of Code 2022
//: ### Day 2: Rock Paper Scissors
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<RPSRound>().parseLines(fileName: "input")

let result = Solver.solve(with: input)
print("Part 1:", result)

let input2 = try DataParser<RPSRoundAlt>().parseLines(fileName: "input")
let result2 = Solver.solve(with: input2)

print("Part 2:", result2)

