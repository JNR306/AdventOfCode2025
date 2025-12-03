import Foundation

func day3Easy() {
    let filePath = "input/input3.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let banks: [String] = fileContents.components(separatedBy: "\n")
        var joltages: [[Character]] = banks.map { Array($0) }
        joltages.removeAll(where: { $0 == [] })
        var sum = 0
        for i in 0..<joltages.count {
            let bank = joltages[i].map { Int(String($0)) ?? 0 }
            let subsetA = bank.prefix(bank.count - 1)
            let firstDigit = subsetA.max()
            let firstDigitIndex = subsetA.firstIndex(of: firstDigit ?? 0) ?? 0
            let subsetB = bank.suffix(bank.count - 1 - firstDigitIndex)
            let secondDigit = subsetB.max()
            sum += Int(String(firstDigit ?? 0) + String(secondDigit ?? 0)) ?? 0
        }
        print(sum)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day3Hard() {
    let filePath = "input/testinput3.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let banks: [String] = fileContents.components(separatedBy: "\n")
        var joltages: [[Character]] = banks.map { Array($0) }
        joltages.removeAll(where: { $0 == [] })
        var sum = 0
        for i in 0..<joltages.count {
            let bank: [Int] = joltages[i].map { Int(String($0)) ?? 0 }

            var indexOfLastDigit = -1
            var remainingSubset: ArraySlice<Int> = []
            var result: String = ""

            for j in (0..<12).reversed() {
                remainingSubset = bank.suffix(bank.count - 1 - indexOfLastDigit)
                remainingSubset = remainingSubset.prefix(remainingSubset.count - j)
                let selectedDigit: Int = remainingSubset.max() ?? 0
                result += String(selectedDigit)
                indexOfLastDigit = remainingSubset.firstIndex(of: selectedDigit) ?? 0
            }

            sum += Int(result) ?? 0
            
            /*
            let zerothDigitIndex = -1
            var subsetA = bank.suffix(bank.count - 1 - zerothDigitIndex)
            subsetA = subsetA.prefix(subsetA.count - 11)
            let firstDigit = subsetA.max()

            let firstDigitIndex = subsetA.firstIndex(of: firstDigit ?? 0) ?? 0
            var subsetB = bank.suffix(bank.count - 1 - firstDigitIndex)
            subsetB = subsetB.prefix(subsetB.count - 10)
            let secondDigit = subsetB.max()

            let secondDigitIndex = subsetB.firstIndex(of: secondDigit ?? 0) ?? 0
            var subsetC = bank.suffix(bank.count - 1 - secondDigitIndex)
            subsetC = subsetC.prefix(subsetC.count - 9)
            let thirdDigit = subsetC.max()

            let thirdDigitIndex = subsetC.firstIndex(of: thirdDigit ?? 0) ?? 0
            var subsetD = bank.suffix(bank.count - 1 - thirdDigitIndex)
            subsetD = subsetD.prefix(subsetD.count - 8)
            let fourthDigit = subsetD.max()

            let fourthDigitIndex = subsetD.firstIndex(of: fourthDigit ?? 0) ?? 0
            var subsetE = bank.suffix(bank.count - 1 - fourthDigitIndex)
            subsetE = subsetE.prefix(subsetE.count - 7)
            let fifthDigit = subsetE.max()

            let fifthDigitIndex = subsetE.firstIndex(of: fifthDigit ?? 0) ?? 0
            var subsetF = bank.suffix(bank.count - 1 - fifthDigitIndex)
            subsetF = subsetF.prefix(subsetF.count - 6)
            let sixthDigit = subsetF.max()

            let sixthDigitIndex = subsetF.firstIndex(of: sixthDigit ?? 0) ?? 0
            var subsetG = bank.suffix(bank.count - 1 - sixthDigitIndex)
            subsetG = subsetG.prefix(subsetG.count - 5)
            let seventhDigit = subsetG.max()

            let seventhDigitIndex = subsetG.firstIndex(of: seventhDigit ?? 0) ?? 0
            var subsetH = bank.suffix(bank.count - 1 - seventhDigitIndex)
            subsetH = subsetH.prefix(subsetH.count - 4)
            let eighthDigit = subsetH.max()

            let eightDigitIndex = subsetH.firstIndex(of: eighthDigit ?? 0) ?? 0
            var subsetI = bank.suffix(bank.count - 1 - eightDigitIndex)
            subsetI = subsetI.prefix(subsetI.count - 3)
            let ninethDigit = subsetI.max()

            let ninethDigitIndex = subsetI.firstIndex(of: ninethDigit ?? 0) ?? 0
            var subsetJ = bank.suffix(bank.count - 1 - ninethDigitIndex)
            subsetJ = subsetJ.prefix(subsetJ.count - 2)
            let tenthDigit = subsetJ.max()

            let tenthDigitIndex = subsetJ.firstIndex(of: tenthDigit ?? 0) ?? 0
            var subsetK = bank.suffix(bank.count - 1 - tenthDigitIndex)
            subsetK = subsetK.prefix(subsetK.count - 1)
            let eleventhDigit = subsetK.max()

            let eleventhDigitIndex = subsetK.firstIndex(of: eleventhDigit ?? 0) ?? 0
            var subsetL = bank.suffix(bank.count - 1 - eleventhDigitIndex)
            subsetL = subsetL.prefix(subsetL.count - 0)
            let twelvethDigit = subsetL.max()

            var s: String = String(firstDigit ?? 0) + String(secondDigit ?? 0) + String(thirdDigit ?? 0) + String(fourthDigit ?? 0) + String(fifthDigit ?? 0)
            s += String(sixthDigit ?? 0) + String(seventhDigit ?? 0) + String(eighthDigit ?? 0) + String(ninethDigit ?? 0) + String(tenthDigit ?? 0)
            s += String(eleventhDigit ?? 0) + String(twelvethDigit ?? 0)
            sum += Int(s) ?? 0
            */

        }
        print(sum)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}