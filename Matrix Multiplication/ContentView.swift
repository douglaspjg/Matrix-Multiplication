//
//  ContentView.swift
//  Matrix Multiplication
//
//  Created by Douglas Pineda-Gutierrez on 4/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var matrixA: String = ""
    @State private var matrixAArray: [[String]] = Array(repeating: Array(repeating: "0", count: 2), count: 2)
    @State private var matrixB: String = ""
    @State private var matrixBArray: [[String]] = Array(repeating: Array(repeating: "0", count: 2), count: 2)
    @State private var result: String = ""
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Text("Matrix A")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            TextField("Matrix A (e.g., 1,2,3;4,5,6)", text: $matrixA)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .multilineTextAlignment(.center)
            ContentView3()
            Text("Matrix B")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ContentView3()
//            TextField("Matrix B (e.g., 7,8;9,10;11,12)", text: $matrixB)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .multilineTextAlignment(.center)
            Button("Multiply Matrices") {
                let matrixAArray = parseMatrixString(self.matrixA)
                let matrixBArray = parseMatrixString(self.matrixB)
                
                guard let resultMatrix = multiplyMatrices(matrixA: matrixAArray, matrixB: matrixBArray) else {
                    self.result = "Cannot multiply matrices."
                    return
                }
                
                self.result = matrixToString(resultMatrix)
            }
            .padding()
            
            Text("Result:")
            Text(result)
                .padding()
        }
        .padding(.top,50)
    }
    
    func multiplyMatrices(matrixA: [[Int]], matrixB: [[Int]]) -> [[Int]]? {
        let rowsA = matrixA.count
        let colsA = matrixA[0].count
        let rowsB = matrixB.count
        let colsB = matrixB[0].count
        
        // Check if matrices can be multiplied
        if colsA != rowsB {
            print("Cannot multiply matrices: Number of columns in matrix A must be equal to the number of rows in matrix B.")
            return nil
        }
        
        var result = Array(repeating: Array(repeating: 0, count: colsB), count: rowsA)
        
        for i in 0..<rowsA {
            for j in 0..<colsB {
                var sum = 0
                for k in 0..<colsA {
                    sum += matrixA[i][k] * matrixB[k][j]
                }
                result[i][j] = sum
            }
        }
        return result
    }

    
    func parseMatrixString(_ matrixString: String) -> [[Int]] {
        let rows = matrixString.components(separatedBy: ";")
        var matrix = [[Int]]()
        
        for row in rows {
            let elements = row.components(separatedBy: ",")
            let rowArray = elements.compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
            matrix.append(rowArray)
        }
        
        return matrix
    }
    
    func matrixToString(_ matrix: [[Int]]) -> String {
        return matrix.map { $0.map(String.init).joined(separator: " ") }
            .joined(separator: "\n")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
