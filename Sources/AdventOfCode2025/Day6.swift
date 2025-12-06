import Foundation

func day6Easy() {
    let filePath = "input/input6.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let lines: [String] = fileContents.components(separatedBy: "\n")
        var values: [[String]] = lines.map { $0.components(separatedBy: " ") }
        for i in 0..<values.count {
            values[i].removeAll(where: { $0 == "" })
        }
        values.removeAll(where: { $0 == [] })
        var sum = 0
        for i in 0..<values[0].count {
            let problem = values[values.count-1][i]
            var result = problem == "+" ? 0 : 1
            for j in 0..<(values.count-1) {
                let value = values[j][i]
                if problem == "+" {
                    result += Int(value) ?? 0
                } else {
                    result *= Int(value) ?? 1
                }
            }
            sum += result
        }
        print(sum)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day6Hard() {
    let filePath = "input/input6.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        let digits = lines.map { Array($0) }
        var sum = 0
        var values: [String] = Array(repeating: "", count: digits[0].count)
        var problem = " "
        for i in 0..<digits[0].count {
            var allEmpty = true
            for j in 0..<(digits.count-1) {
                let digit = digits[j][i]
                if digit != " " {
                    allEmpty = false
                }
            }
            if digits[digits.count-1][i] != " " {
                problem = String(digits[digits.count-1][i])
            }
            if allEmpty {
                // Do calculation
                for j in 0..<values.count {
                    values[j] = values[j].trimmingCharacters(in: .whitespaces)
                }
                let numbers = values.map { Int($0) ?? (problem == "+" ? 0 : 1) }
                //print(numbers)
                sum += problem == "+" ? numbers.reduce(0, +) : numbers.reduce(1, *)
                values = Array(repeating: "", count: digits[0].count)
                problem = " "
                continue
            }
            for j in 0..<(digits.count-1) {
                let digit = digits[j][i]
                //print(digit)
                values[i] += String(digit)
            }
        }
        // Do calculation
        for j in 0..<values.count {
            values[j] = values[j].trimmingCharacters(in: .whitespaces)
        }
        let numbers = values.map { Int($0) ?? (problem == "+" ? 0 : 1) }
        sum += problem == "+" ? numbers.reduce(0, +) : numbers.reduce(1, *)
        print(sum)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}