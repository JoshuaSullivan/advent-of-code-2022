//: # Advent of Code 2022
//: ### Day 6: Tuning Trouble
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try DataParser<String>().loadDataString(from: "input")
let test1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
let test2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
let test3 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
let test4 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

let result = Solver.solve(with: input, markerSize: 4)
print("Part 1:", result)

let result2 = Solver.solve(with: input, markerSize: 14)
print("Part 2:", result2)
