//: # Advent of Code 2022
//: ### Day 5: Supply Stacks
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let startingCrates = try DataParser<String>().parseCSVLines(fileName: "crates")
let moveList = try DataParser<Move>().parseLines(fileName: "moves")

let result = Solver.solve(with: startingCrates, moves: moveList)
print("Part 1:", result)

let result2 = Solver.solve2(with: startingCrates, moves: moveList)
print("Part 2:", result2)
