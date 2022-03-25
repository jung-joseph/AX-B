//
//  HilbertViewModel.swift
//  AX=B
//
//  Created by Joseph Jung on 3/15/22.
//

import Foundation
import SwiftUI

class HilbertViewModel: ObservableObject {
    
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    var hilbertSizeText: String
    var hilbertMatrix: [[Double]]
    
    init(equations: Equations, system: Gauss, hilbertSizeText: String) {
        
        self.equations = equations
        self.system = system
        self.hilbertSizeText = hilbertSizeText
        self.hilbertMatrix = Array(repeating: Array(repeating: 0.0, count: Int(hilbertSizeText) ?? 2), count: Int(hilbertSizeText) ?? 2)
    }
    
    func createHilbert(){
        
        // This function should create and populate the equation object with the desired Hilbert matrix
        
        
        let hilbertObject = Hilbert(order: Int(hilbertSizeText)  ?? 2 )
        hilbertMatrix = hilbertObject.hilbertMatrix()
//        hilbertObject.printHilbertMatrix()
        
        
    }
}
