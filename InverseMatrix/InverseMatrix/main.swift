//
//  main.swift
//  InverseMatrix
//
//  Created by Simeon on 27.07.22.
//

import Foundation

func readNumber() -> Int {
    
    repeat {
        guard let line = readLine(), let number = Int(line) else {
            print("Thats not a number")
            continue
        }
        return number
        
    } while true
}

protocol Matrix {
    var matrix: [[Int]] {get}
    var matrixDimension: Int {get}
    
    func getInverseMatrix() throws -> [[Double]]
    
}
enum DiscriminantErrors: Error {
    case discriminantEqualTo_0
}

struct Matrix2x2: Matrix {
    
    var matrix: [[Int]] = []
    var matrixDimension = 2
    
    init() {
        for x in 0...matrixDimension - 1 {
            var temp: [Int] = []
            for y in 0...matrixDimension - 1 {
                print("Number at position \(x),\(y)")
                temp.append(readNumber())
            }
            matrix.append(temp)
        }
        print(matrix)
    }
    
    func getInverseMatrix() throws -> [[Double]] {
        
        var inverseMatrix: [[Double]] = [[]]
        inverseMatrix = [[Double]](repeating: [Double](repeating: 0, count: 2), count: 2)
        
        var discriminant: Double
        discriminant = (Double(matrix[0][0]) * Double(matrix[1][1]))
                        - (Double(matrix[0][1]) * Double(matrix[1][0]))
        print("Discriminant is \(discriminant)" )
        guard discriminant != 0 else {
            throw DiscriminantErrors.discriminantEqualTo_0
        }
        
        inverseMatrix[0][0] = Double(matrix[1][1])
        inverseMatrix[0][1] = -Double((matrix[0][1]))
        inverseMatrix[1][0] = -Double((matrix[1][0]))
        inverseMatrix[1][1] = Double(matrix[0][0])
        
        inverseMatrix[0][0] = inverseMatrix[0][0] / discriminant
        inverseMatrix[0][1] = inverseMatrix[0][1] / discriminant
        inverseMatrix[1][0] = inverseMatrix[1][0] / discriminant
        inverseMatrix[1][1] = inverseMatrix[1][1] / discriminant
        
        
        return inverseMatrix
    }
}

 struct Matrix3x3: Matrix {
    
    var matrix: [[Int]] = []
    var matrixDimension = 3
     
    init() {
        //matrix = [[1, 2, 3], [0, 1, 4], [5, 6, 0]]
        for x in 0...matrixDimension - 1 {
            var temp: [Int] = []
            for y in 0...matrixDimension - 1 {
                //print("\(x),\(y) is \(matrix[x][y])")
                print("Number at position \(x),\(y)")
                temp.append(readNumber())
            }
            matrix.append(temp)
        }
        print(matrix)
    }
    func getInverseMatrix() throws -> [[Double]] {
        
        var inverseMatrix: [[Double]] = [[]]
        inverseMatrix = [[Double]](repeating: [Double](repeating: 0, count: 3), count: 3)
        
        let discriminant = Double(matrix[0][0] * (matrix[1][1] * matrix[2][2] - matrix[1][2] * matrix[2][1]))
                                                                       
                       - Double(matrix[0][1] * (matrix[1][0] * matrix[2][2] - matrix[1][2] * matrix[2][0]))

                        + Double(matrix[0][2] * (matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0]))
        
        print("Discriminant is \(discriminant)")
        
        guard discriminant != 0 else {
            throw DiscriminantErrors.discriminantEqualTo_0
        }
                                                                       
        var transposeMatrix: [[Int]] = [[]]
        transposeMatrix = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3)
        
        transposeMatrix[0][0] = matrix[0][0]
        transposeMatrix[1][0] = matrix[0][1]
        transposeMatrix[2][0] = matrix[0][2]
        
        transposeMatrix[0][1] = matrix[1][0]
        transposeMatrix[1][1] = matrix[1][1]
        transposeMatrix[2][1] = matrix[1][2]
        
        transposeMatrix[0][2] = matrix[2][0]
        transposeMatrix[1][2] = matrix[2][1]
        transposeMatrix[2][2] = matrix[2][2]
        
        //print(transposeMatrix)
        
        let minorMatrix1 = transposeMatrix[1][1] * transposeMatrix[2][2] - transposeMatrix[1][2] * transposeMatrix[2][1]
        let minorMatrix2 = transposeMatrix[1][0] * transposeMatrix[2][2] - transposeMatrix[1][2] * transposeMatrix[2][0]
        let minorMatrix3 = transposeMatrix[1][0] * transposeMatrix[2][1] - transposeMatrix[1][1] * transposeMatrix[2][0]
        let minorMatrix4 = transposeMatrix[0][1] * transposeMatrix[2][2] - transposeMatrix[0][2] * transposeMatrix[2][1]
        let minorMatrix5 = transposeMatrix[0][0] * transposeMatrix[2][2] -
            transposeMatrix[0][2] * transposeMatrix[2][0]
        let minorMatrix6 = transposeMatrix[0][0] * transposeMatrix[2][1] - transposeMatrix[0][1] * transposeMatrix[2][0]
        let minorMatrix7 = transposeMatrix[0][1] * transposeMatrix[1][2] -
            transposeMatrix[0][2] * transposeMatrix[1][1]
        let minorMatrix8 = transposeMatrix[0][0] * transposeMatrix[1][2] -
            transposeMatrix[0][2] * transposeMatrix[1][0]
        let minorMatrix9 = transposeMatrix[0][0] * transposeMatrix[1][1] -
            transposeMatrix[0][1] * transposeMatrix[1][0]
        
        var adjugate: [[Double]] = []
        adjugate = [[Double]](repeating: [Double](repeating: 0, count: 3), count: 3)
        
        adjugate[0][0] = Double(minorMatrix1)
        adjugate[0][1] = -Double(minorMatrix2)
        adjugate[0][2] = Double(minorMatrix3)
        
        adjugate[1][0] = -Double(minorMatrix4)
        adjugate[1][1] = Double(minorMatrix5)
        adjugate[1][2] = -Double(minorMatrix6)
        
        adjugate[2][0] = Double(minorMatrix7)
        adjugate[2][1] = -Double(minorMatrix8)
        adjugate[2][2] = Double(minorMatrix9)
        
        inverseMatrix[0][0] = adjugate[0][0] / discriminant
        inverseMatrix[0][1] = adjugate[0][1] / discriminant
        inverseMatrix[0][2] = adjugate[0][2] / discriminant
        
        inverseMatrix[1][0] = adjugate[1][0] / discriminant
        inverseMatrix[1][1] = adjugate[1][1] / discriminant
        inverseMatrix[1][2] = adjugate[1][2] / discriminant
        
        inverseMatrix[2][0] = adjugate[2][0] / discriminant
        inverseMatrix[2][1] = adjugate[2][1] / discriminant
        inverseMatrix[2][2] = adjugate[2][2] / discriminant
                                                            
        return inverseMatrix
    }
}

let matrix1 = Matrix2x2()
print(try matrix1.getInverseMatrix())

let matrix3x3 = Matrix3x3()
print(try matrix3x3.getInverseMatrix())


