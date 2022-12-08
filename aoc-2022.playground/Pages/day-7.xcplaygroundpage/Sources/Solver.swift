import Foundation

public struct Solver {
    public static func solve(with input: [String]) -> Int {
        
        let _ = process(input)
        
        return Directory.allDirs
            .map { $0.getSize() }
            .filter { $0 < 100_000 }
            .reduce(0, +)
    }
    
    public static func solve2(with input: [String]) -> Int {
        let root = process(input)
        let totalSize = 70_000_000
        let startingSize = root.getSize()
        let remainingSize = totalSize - startingSize
        let targetSize = 30_000_000
        
        return Directory.allDirs
            .map { $0.getSize() }
            .sorted()
            .first(where: { dirSize in
                return remainingSize + dirSize >= targetSize
            })!
    }
    
    private static func process(_ input: [String]) -> Directory {
        let root = Directory(name: "/")
        var pwd = root
        
//        print(input.count, "lines.")
        let groups = input.chunked { a, b in
            return b.first != "$"
        }
        
        for group in groups {
            let command = group.first!.split(separator: " ").dropFirst()
            switch command.first! {
            case "cd":
                let dirName = String(command.last!)
//                print("cd", dirName)
                if dirName == "/" {
                    pwd = root
                } else if dirName == "..", let parent = pwd.parentDirectory {
                    pwd = parent
                } else if let subdir = pwd.subdir(named: String(dirName)) {
                    pwd = subdir
                } else {
                    fatalError("Can't find directory '\(dirName)'.")
                }
//                print(pwd.path)
            case "ls":
//                print("ls")
                let items = group.dropFirst()
//                print(items.count, "items:")
//                items.forEach { print("\t\($0)") }
                pwd.add(listing: items)
            default:
                fatalError("Unknown command encountered.")
            }
        }
        
//        print(root)
        
        return root
    }
}

public class Directory: Equatable, Comparable, CustomStringConvertible {
    
    public static var allDirs: [Directory] = []
    
    public struct File: StringInitable, CustomStringConvertible {
        public let size: Int
        public let name: String
        
        public init?(_ string: String) {
            let parts = string.split(separator: " ")
            assert(parts.count == 2, "Incorrect format for file.")
            guard let size = Int(parts[0]) else {
                assertionFailure("Couldn't parse file size.")
                return nil
            }
            self.size = size
            self.name = String(parts[1])
        }
        
        public var description: String {
            "- \(name) (file, size=\(size))"
        }
    }
    
    public var name: String
    public var files: [File] = []
    public var subdirectories: [Directory] = []
    public weak var parentDirectory: Directory? = nil
    
    public init(name: String) {
        self.name = name
        Self.allDirs.append(self)
    }
    
    public func add(listing items: ArraySlice<String>) {
        for item in items {
            let parts = item.split(separator: " ")
            if parts[0] == "dir" {
                let subdir = Directory(name: String(parts[1]))
                subdir.parentDirectory = self
                subdirectories.append(subdir)
            } else {
                guard let file = File(item) else { fatalError("Could not parse file.") }
                files.append(file)
            }
        }
    }
    
    public func getSize() -> Int {
        let fileSize = files.reduce(0) { $0 + $1.size }
        let dirSize = subdirectories.reduce(0) { $0 + $1.getSize() }
        return fileSize + dirSize
    }
    
    public func subdir(named name: String) -> Directory? {
        return subdirectories
            .filter({ $0.name == name })
            .first
    }
    
    public func hasSubdir(named name: String) -> Bool {
        return subdir(named: name) != nil
    }
    
    public static func == (lhs: Directory, rhs: Directory) -> Bool {
        return lhs.name == rhs.name
    }
    
    public static func < (lhs: Directory, rhs: Directory) -> Bool {
        return lhs.name < rhs.name
    }
    
    public var path: String {
        guard let parent = parentDirectory else { return name }
        return parent.path + "/" + name
    }
    
    public var description: String {
        return description(withInset: 0)
    }
    
    public func description(withInset inset: Int) -> String {
        var output = spacer(inset) + "- \(name) (dir)\n"
        for subdir in subdirectories.sorted() {
            output += subdir.description(withInset: inset + 1)
        }
        for file in files {
            output += spacer(inset + 1) + file.description + "\n"
        }
        return output
    }
    
    private func spacer(_ inset: Int) -> String {
        guard inset > 0 else { return "" }
        return (0..<inset).reduce("") { result, _ in result + "  "}
    }
}
