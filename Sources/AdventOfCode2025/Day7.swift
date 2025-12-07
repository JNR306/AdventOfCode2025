import Foundation

func day7Easy() {
    let filePath = "input/input7.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        var map: [[Character]] = lines.map { Array($0) }
        var splitCount = 0
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if map[y][x] == "S" || map[y][x] == "T" {
                    if map[y][x] == "T" {
                        map[y][x] = "|"
                    }
                    var currentY = y + 1
                    while currentY < map.count && map[currentY][x] == "." {
                        map[currentY][x] = "|"
                        currentY += 1
                    }
                    if currentY < map.count && map[currentY][x] == "^" {
                        map[currentY][x - 1] = "T"
                        map[currentY][x + 1] = "T"
                        splitCount += 1
                    }
                }
            }
        }
        print(splitCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day7Hard() {
    let filePath = "input/input7.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        let map: [[Character]] = lines.map { Array($0) }
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if map[y][x] == "S" {
                    var knownPathCounts: [Coordinate: Int] = [:]
                    print(day7HardHelper(map: map, pos: Coordinate(y: y, x: x), knownPathCounts: &knownPathCounts) / 2)
                }
            }
        }
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day7HardHelper(map: [[Character]], pos: Coordinate, knownPathCounts: inout [Coordinate: Int]) -> Int {
    if pos.y >= map.count {
        return 1
    }
    var currentY = pos.y + 1
    while currentY < map.count && map[currentY][pos.x] == "." {
        currentY += 1
    }
    if let pathCount = knownPathCounts[Coordinate(y: currentY, x: pos.x)] {
        return pathCount
    }
    let pathCountLeft = day7HardHelper(map: map, pos: Coordinate(y: currentY, x: pos.x - 1), knownPathCounts: &knownPathCounts)
    let pathCountRight = day7HardHelper(map: map, pos: Coordinate(y: currentY, x: pos.x + 1), knownPathCounts: &knownPathCounts)
    knownPathCounts[Coordinate(y: currentY, x: pos.x)] = pathCountLeft + pathCountRight
    return pathCountLeft + pathCountRight
}

struct Coordinate: Hashable {
    let y: Int
    let x: Int
}