//: # Advent of Code 2022
//: ### Day 1: Calorie Counting
//: [Next](@next)

import Foundation

guard let input = try? DataParser<Int>().parseDoubleNewlineGroupsOfLines(fileName: "input") else {
    fatalError("Couldn't read file.")
}

guard let result = Solver.solve(with: input) else {
    fatalError("Didn't get a result.")
}

print("Part 1:", result)

guard let result2 = Solver.solve2(with: input) else {
    fatalError("Didn't get a result.")
}

print("Part 2:", result2)
