//: # Advent of Code 2022
//: ### Day 4: Camp Cleanup
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<ClosedRange<Int>>().parseCSVLines(fileName: "input")

let result = Solver.solve(with: input)
print("Part 1:", result)


let result2 = Solver.solve2(with: input)
print("Part 2:", result2)
