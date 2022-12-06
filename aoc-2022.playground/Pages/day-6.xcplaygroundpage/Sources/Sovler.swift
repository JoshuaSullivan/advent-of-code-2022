import Foundation

public struct Solver {
    public static func solve(with input: String, markerSize size: Int) -> Int {
        let windows = input.windows(ofCount: size)
        let index = windows.firstIndex(where: { Set($0).count == size })!
        return windows.distance(from: windows.startIndex, to: index) + size
    }
}
