//
//  i by j 2.swift
//  Matrix Multiplication
//
//  Created by Douglas Pineda-Gutierrez on 4/14/24.
//

import Foundation

import SwiftUI

struct MatrixInputView2: View {
    @Binding var matrix: [[String]]
        
    var body: some View {
        VStack {
            ForEach(0..<matrix.count, id: \.self) { i in
                HStack {
                    ForEach(0..<self.matrix[i].count, id: \.self) { j in
                        TextField("0", text: self.$matrix[i][j])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50, height: 30)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }
}

struct ContentView3: View {
    @State private var numRows: Int = 2
    @State private var numCols: Int = 2
    @State var matrix: [[String]] = Array(repeating: Array(repeating: "0", count: 2), count: 2)
    
    var body: some View {
        VStack {
            MatrixInputView2(matrix: $matrix).padding(.bottom,32)
            HStack {
                Spacer()
                VStack {
                    Stepper(value: $numRows, in: 1...8) {
                        Text("Rows: \(numRows)").fixedSize(horizontal: true, vertical: true)
                    }
                }
                Spacer()
                VStack {
                    Stepper(value: $numCols, in: 1...8) {
                        Text("Columns: \(numCols)").fixedSize(horizontal: true, vertical: true)
                    }
                }
                Spacer()
            }
        }
        .padding()
        .onChange(of: numRows) {
            updateMatrix()
        }
        .onChange(of: numCols) {
            updateMatrix()
        }
    }
    
    func updateMatrix() {
        let oldNumRows = matrix.count
        let oldNumCols = matrix[0].count
        // make an empty array with the new correct size, whether that be smaller or larger than the orignal
        var newMatrix:[[String]] = Array(repeating: Array(repeating: "0", count: numCols), count: numRows)
        // change the indices.
        if numRows > oldNumRows {
            // you're going to add a new row of 0s by concat
            matrix.append(Array(repeating: "0", count: numCols))
        } else if numCols > oldNumCols {
            // you're going to add a 0 to the end of every smaller araray
            for i in 0...matrix.count-1 {
                matrix[i].append("0")
            }
        } else {
            for i in 0...numRows-1 {
                for j in 0...numCols-1 {
                    // it could be the case that num rows is smaller, in which case this would be okay. Same for columns
                    // the only problem is if you are adding a row
                    newMatrix[i][j] = matrix[i][j]
                }
            }
            matrix = newMatrix
        }
    }
}
    

struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}
