import Foundation

func day1Easy() {
    let filePath = "input/input1.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let rotations = fileContents.components(separatedBy: "\n")
        var pos = 50
        var zeroCount = 0
        for rotation in rotations {
            let rotationDirection = rotation.prefix(1)
            let rotationAmount = rotation.suffix(max(0,rotation.count-1))
            if rotationDirection != "" && rotationAmount != "" {
                if rotationDirection == "R" {
                    pos = (pos + (Int(rotationAmount) ?? 0)) % 100
                } else {
                    pos = (pos - (Int(rotationAmount) ?? 0)) % 100
                }
            }
            if pos == 0 {
                zeroCount += 1
            }
        }
        print(zeroCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day1Hard() {
    let filePath = "input/input1.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let rotations = fileContents.components(separatedBy: "\n")
        var pos = 50
        var zeroCount = 0
        for rotation in rotations {
            let rotationDirection = rotation.prefix(1)
            let rotationAmount = rotation.suffix(max(0,rotation.count-1))
            if rotationDirection != "" && rotationAmount != "" {
                if rotationDirection == "R" {
                    for _ in 0..<(Int(rotationAmount) ?? 0) {
                        pos = (pos + 1) % 100
                        if pos == 0 {
                            zeroCount += 1
                        }
                    }
                } else {
                    for _ in 0..<(Int(rotationAmount) ?? 0) {
                        pos = (pos - 1) % 100
                        if pos == 0 {
                            zeroCount += 1
                        }
                    }
                }
            }
        }
        print(zeroCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}