//
//  i by j.swift
//  Matrix Multiplication
//
//  Created by Douglas Pineda-Gutierrez on 4/14/24.
//

import Foundation

import SwiftUI

struct MatrixInputView: View {
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

struct ContentView2: View {
    @State private var numRows: Int = 2
    @State private var numCols: Int = 2
    @State private var matrix: [[String]] = Array(repeating: Array(repeating: "0", count: 2), count: 2)
    
    var body: some View {
        VStack {
            HStack {
                Text("Rows:")
                Stepper(value: $numRows, in: 1...10) {
                    Text("\(numRows)")
                }
                
                Text("Columns:")
                Stepper(value: $numCols, in: 1...10) {
                    Text("\(numCols)")
                }
            }
            MatrixInputView(matrix: $matrix)
            
            Button("Print Matrix") {
                print(self.matrix)
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

