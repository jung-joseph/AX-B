//
//  HilbertMatrix.swift
//  AX=B
//
//  Created by Joseph Jung on 3/15/22.
//

import Foundation

class Hilbert: ObservableObject {
    var order: Int
    
    @Published var matrix: [[Double]]
    
    init(order: Int){
        self.order = order
        
        matrix = Array(repeating: Array(repeating: 0.0, count: order), count: order)
    }
    
    func hilbertMatrix()-> [[Double]]{
        for i in  0..<self.order {
            let indexI = i + 1
            for j in  0..<self.order {
                let indexJ = j + 1
                matrix[i][j] = elements(i: indexI, j: indexJ)
            }
        }
        return matrix
    }
    
    func elements(i: Int, j: Int)-> Double {
        let hij = 1.0/Double((i+j-1))
        return hij
    }
    
    func printHilbertMatrix() {
        print("Hilbert Matrix")
        
        for array in matrix {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        

        print()
    }
}
