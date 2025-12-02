import Foundation

func day2Easy() {
    let filePath = "input/input2.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        var fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        fileContents.removeAll(where: { $0 == "\n" })
        let ranges = fileContents.components(separatedBy: ",")
        var repeatedCount = 0
        var repeatedValue = 0
        for range in ranges {
            let startAndEnd = range.components(separatedBy: "-")
            for i in (Int(startAndEnd[0]) ?? 0)...(Int(startAndEnd[1]) ?? 0) {
                if String(i).count % 2 == 1 {
                    continue
                }
                if String(i).prefix(String(i).count / 2) == String(i).suffix(String(i).count / 2) {
                    repeatedCount += 1
                    repeatedValue += i
                }
            }
        }
        print(repeatedValue)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day2Hard() {
    //345995423801866
    let filePath = "input/input2.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        var fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        fileContents.removeAll(where: { $0 == "\n" })
        let ranges = fileContents.components(separatedBy: ",")
        var repeatedCount = 0
        var repeatedValue = 0
        for range in ranges {
            let startAndEnd = range.components(separatedBy: "-")
            for i in (Int(startAndEnd[0]) ?? 0)...(Int(startAndEnd[1]) ?? 0) {
                // itersate through all possible ids
                var allCombinationsCorrect = false
                if String(i).count == 1 { continue } //one digit number cannot have a pattern repeated at least twice
                outerLoop: for j in 1...(String(i).count/2) {
                    //check if id consists only of j digits repeated
                    if String(i).count % j == 0 && String(i).count / j >= 2 { //if the modulo is not 0, then the string cannot be made up of repeating j long patterns and the amount the pattern is repeated must be greater or equal to 2
                        let firstString = String(i)
                        let firstStartIndex = firstString.index(firstString.startIndex, offsetBy: 0)
                        let firstEndIndex = firstString.index(firstString.startIndex, offsetBy: j)
                        let firstSubstring = firstString[firstStartIndex..<firstEndIndex]
                        var allSubstringsCorrect = true
                        for k in 0..<(String(i).count / j) {
                            let string = String(i)
                            let startIndex = string.index(string.startIndex, offsetBy: j * k)
                            let endIndex = string.index(string.startIndex, offsetBy: (j * k) + j)
                            let substring = string[startIndex..<endIndex]
                            if firstSubstring != substring {
                                allSubstringsCorrect = false
                                break
                            }
                        }
                        if allSubstringsCorrect {
                            allCombinationsCorrect = true
                        }
                    }
                }
                if allCombinationsCorrect {
                    repeatedCount += 1
                    repeatedValue += i
                }
            }
        }
        print(repeatedValue)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}