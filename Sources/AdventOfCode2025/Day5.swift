import Foundation

func day5Easy() {
    let filePath = "input/input5.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let parts: [String] = fileContents.components(separatedBy: "\n\n")
        let ranges = parts[0].components(separatedBy: "\n")
        let ids = parts[1].components(separatedBy: "\n")
        var freshCount = 0
        for id in ids {
            if id != "" {
                for range in ranges {
                    let startAndEndPoint = range.components(separatedBy: "-")
                    if (Int(id) ?? 0) >= (Int(startAndEndPoint[0]) ?? 0) && (Int(id) ?? 0) <= (Int(startAndEndPoint[1]) ?? 0) {
                        freshCount += 1
                        break
                    }
                }
            }
        }
        print(freshCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day5Hard() {
    /*
    let filePath = "input/input5.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        let parts: [String] = fileContents.components(separatedBy: "\n\n")
        let ranges = parts[0].components(separatedBy: "\n")
        var ids: [Int] = []
        for range in ranges {
            let startAndEndPoint = range.components(separatedBy: "-")
            for id in (Int(startAndEndPoint[0]) ?? 0)...(Int(startAndEndPoint[1]) ?? 0) {
                if !ids.contains(id) {
                ids.append(id)
                }
            }
        }
        print(ids.count)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
    */
    let filePath = "input/input5.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        let parts: [String] = fileContents.components(separatedBy: "\n\n")
        var ranges = parts[0].components(separatedBy: "\n")
        var exclusiveRanges = ranges
        for _ in 0..<ranges.count {
            for i in 0..<ranges.count {
                let rangeA = ranges[i]
                if rangeA == "" {
                    continue
                }
                let startAndEndPointA = rangeA.components(separatedBy: "-")
                let startPointA = Int(startAndEndPointA[0]) ?? 0
                let endPointA = Int(startAndEndPointA[1]) ?? 0
                for j in 0..<ranges.count {
                    let rangeB = ranges[j]
                    if rangeB == "" {
                        continue
                    }
                    if i == j {
                        continue
                    }
                    if rangeA == rangeB {
                        // A and B are equal -> Make sure it only exists a single time
                        exclusiveRanges.removeAll(where: { $0 == rangeA } )
                        exclusiveRanges.append(rangeA)
                        continue
                    }
                    let startAndEndPointB = rangeB.components(separatedBy: "-")
                    let startPointB = Int(startAndEndPointB[0]) ?? 0
                    let endPointB = Int(startAndEndPointB[1]) ?? 0
                    if endPointA < startPointB || startPointA > endPointB {
                        // A and B are not overlapping -> No change
                        continue
                    }
                    if startPointB >= startPointA && endPointB <= endPointA {
                        // B is fully in A -> Delete B
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointB)-\(endPointB)" } )
                    } else if startPointB >= startPointA && endPointA <= endPointB {
                        // B is overlapping but contains higher ids than A
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointA)-\(endPointB)" } )
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointA)-\(endPointA)" } )
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointB)-\(endPointB)" } )
                        exclusiveRanges.append("\(startPointA)-\(endPointB)")
                    } else if startPointA >= startPointB && endPointB <= endPointA {
                        // B is overlapping but contains lower ids than A
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointB)-\(endPointA)" } )
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointA)-\(endPointA)" } )
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointB)-\(endPointB)" } )
                        exclusiveRanges.append("\(startPointB)-\(endPointA)")
                    } else if startPointA >= startPointB && endPointA <= endPointB {
                        // A is fully in B -> Delete A
                        exclusiveRanges.removeAll(where: { $0 == "\(startPointA)-\(endPointA)" } )
                    }
                }
                
            }
            ranges = exclusiveRanges
        }
        var freshCount = 0
        for exclusiveRange in exclusiveRanges {
            if exclusiveRange == "" {
                continue
            }
            let startAndEndPoint = exclusiveRange.components(separatedBy: "-")
            let startPoint = Int(startAndEndPoint[0]) ?? 0
            let endPoint = Int(startAndEndPoint[1]) ?? 0
            freshCount += endPoint-startPoint+1
        }
        print(freshCount)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}