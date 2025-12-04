import Foundation

func day4Easy() {
    let filePath = "input/input4.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        let diagram: [[Character]] = lines.map { Array($0) }
        var rollCount = 0
        for y in 0..<diagram.count {
            for x in 0..<diagram[y].count {
                if diagram[y][x] != "@" { continue }
                var rollsAdjacentCount = 0
                if x-1 >= 0 && diagram[y][x-1] == "@" { rollsAdjacentCount += 1 }
                if x+1 < diagram[y].count && diagram[y][x+1] == "@" { rollsAdjacentCount += 1 }
                if y-1 >= 0 && diagram[y-1][x] == "@" { rollsAdjacentCount += 1 }
                if y+1 < diagram.count && diagram[y+1][x] == "@" { rollsAdjacentCount += 1 }
                if x-1 >= 0 && y-1 >= 0 && diagram[y-1][x-1] == "@" { rollsAdjacentCount += 1 }
                if x+1 < diagram[y].count && y-1 >= 0 && diagram[y-1][x+1] == "@" { rollsAdjacentCount += 1 }
                if x-1 >= 0 && y+1 < diagram.count && diagram[y+1][x-1] == "@" { rollsAdjacentCount += 1 }
                if x+1 < diagram[y].count && y+1 < diagram.count && diagram[y+1][x+1] == "@" { rollsAdjacentCount += 1 }
                if rollsAdjacentCount < 4 { rollCount += 1 }
            }
        }
        print(rollCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day4Hard() {
    let filePath = "input/input4.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        var diagram: [[Character]] = lines.map { Array($0) }
        var totalRollCount = 0
        var rollCount = 0
        repeat {
            totalRollCount += rollCount
            rollCount = 0
            for y in 0..<diagram.count {
                for x in 0..<diagram[y].count {
                    if diagram[y][x] != "@" { continue }
                    var rollsAdjacentCount = 0
                    if x-1 >= 0 && diagram[y][x-1] == "@" { rollsAdjacentCount += 1 }
                    if x+1 < diagram[y].count && diagram[y][x+1] == "@" { rollsAdjacentCount += 1 }
                    if y-1 >= 0 && diagram[y-1][x] == "@" { rollsAdjacentCount += 1 }
                    if y+1 < diagram.count && diagram[y+1][x] == "@" { rollsAdjacentCount += 1 }
                    if x-1 >= 0 && y-1 >= 0 && diagram[y-1][x-1] == "@" { rollsAdjacentCount += 1 }
                    if x+1 < diagram[y].count && y-1 >= 0 && diagram[y-1][x+1] == "@" { rollsAdjacentCount += 1 }
                    if x-1 >= 0 && y+1 < diagram.count && diagram[y+1][x-1] == "@" { rollsAdjacentCount += 1 }
                    if x+1 < diagram[y].count && y+1 < diagram.count && diagram[y+1][x+1] == "@" { rollsAdjacentCount += 1 }
                    if rollsAdjacentCount < 4 {
                        rollCount += 1
                        diagram[y][x] = "."
                    }
                }
            }
        } while rollCount > 0
        print(totalRollCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}