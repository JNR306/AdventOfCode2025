import Foundation

func day8Easy() {
    let filePath = "input/input8.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        let points: [Point3D] = lines.map { Point3D(x: Int($0.components(separatedBy: ",")[0]) ?? 0, y: Int($0.components(separatedBy: ",")[1]) ?? 0, z: Int($0.components(separatedBy: ",")[2]) ?? 0) }
        //print(points)
        var distances: [(A: Point3D, B: Point3D, d: Double)] = []
        for i in 0..<points.count {
            let pointA = points[i]
            for j in 0..<points.count {
                let pointB = points[j]
                if i >= j { continue }
                let distance = sqrt( pow(Double(pointB.x-pointA.x), 2.0) + pow(Double(pointB.y-pointA.y), 2.0) + pow(Double(pointB.z-pointA.z), 2.0) )
                distances.append((A: pointA, B: pointB, d: distance))
            }
        }
        distances.sort(by: { lhs, rhs in
            return lhs.d < rhs.d
        })
        let shortestDistances = distances.prefix(1000) // Change to 10 for test input
        //print(shortestDistances)

        var circuits: [[Point3D]] = []

        sD: for shortestDistance in shortestDistances {
            for c in 0..<circuits.count {
                let circuit = circuits[c]
                for p in 0..<circuit.count {
                    let point = circuit[p]

                    if shortestDistance.A == point || shortestDistance.B == point {
                        // If new point already exists in another circuit -> find it and move the circuit over
                        for d in 0..<circuits.count {
                            if c == d || d >= circuits.count { continue }
                            let dcircuit = circuits[d]
                            for q in 0..<dcircuit.count {
                                let qpoint = dcircuit[q]
                                if shortestDistance.A == qpoint || shortestDistance.B == qpoint {
                                    circuits[c].append(contentsOf: circuits.remove(at: d))
                                }
                            }
                        }
                        // Add new point
                        circuits[c].removeAll(where: { $0 == (shortestDistance.A == point ? shortestDistance.B : shortestDistance.A) } )
                        circuits[c].append(shortestDistance.A == point ? shortestDistance.B : shortestDistance.A)
                        continue sD
                    }
                }
            }
            circuits.append([shortestDistance.A, shortestDistance.B])
        }

        //print(circuits)
        var circuitSizes = circuits.map { $0.count }
        circuitSizes.sort()
        let largestCircuitSizes = circuitSizes.suffix(3)
        let result = largestCircuitSizes.reduce(1, *)
        print(result)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

func day8Hard() {
    let filePath = "input/input8.txt"
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        //print(fileContents)
        var lines: [String] = fileContents.components(separatedBy: "\n")
        lines.removeAll(where: { $0 == "" })
        let points: [Point3D] = lines.map { Point3D(x: Int($0.components(separatedBy: ",")[0]) ?? 0, y: Int($0.components(separatedBy: ",")[1]) ?? 0, z: Int($0.components(separatedBy: ",")[2]) ?? 0) }
        //print(points)
        var distances: [(A: Point3D, B: Point3D, d: Double)] = []
        for i in 0..<points.count {
            let pointA = points[i]
            for j in 0..<points.count {
                let pointB = points[j]
                if i >= j { continue }
                let distance = sqrt( pow(Double(pointB.x-pointA.x), 2.0) + pow(Double(pointB.y-pointA.y), 2.0) + pow(Double(pointB.z-pointA.z), 2.0) )
                distances.append((A: pointA, B: pointB, d: distance))
            }
        }
        distances.sort(by: { lhs, rhs in
            return lhs.d < rhs.d
        })

        let pointCount = points.count
        var usedPoints: Set<Point3D> = []
        var result: Int = 0

        for distance in distances {
            usedPoints.insert(distance.A)
            usedPoints.insert(distance.B)
            if usedPoints.count == pointCount {
                result = distance.A.x * distance.B.x
                break
            }
        }
        print(result)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
}

struct Point3D: Hashable {
    let x: Int
    let y: Int
    let z: Int
}