//
//  HilbertView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/15/22.
//

import SwiftUI

struct HilbertView: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    @Binding var showHilbert: Bool
    @Binding var hilbertSizeText: String
    @Binding var numEqsText: String
    @Binding var numEqs: Int
    @Binding var showEquationView: Bool
    @Binding var showVerification: Bool
    
    var body: some View {
        VStack{
     Text("Hilbert Matrix")
                .foregroundColor(.blue)
                .font(.title)
            
            TextField("Size of Matrix", text: $hilbertSizeText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .font(.custom("Arial", size: 15)).fixedSize()
                .foregroundColor(Color.black)
                .colorScheme(.light)
                .keyboardType(.decimalPad)
            
            HStack{
                Button(action: {
                    self.showHilbert = false
                    self.showVerification = false
                    self.showEquationView = true

                    
                    
                    
                    // create Hilbert matrix
                    let hilbertViewModel = HilbertViewModel(equations: equations, system: system, hilbertSizeText: hilbertSizeText)
                    hilbertViewModel.createHilbert()
                    
                    
                    // create a new problem
                    self.numEqsText = hilbertSizeText
                    self.numEqs = Int(hilbertSizeText) ?? 2
                    // Update the equations object
                    let tempEquations = Equations(neq: self.numEqs)
                    for i in 0..<hilbertViewModel.hilbertMatrix.count {
                            tempEquations.bMatrixText[i] = "1.0"
                        for j in 0..<hilbertViewModel.hilbertMatrix.count {
                            tempEquations.aMatrixText[i][j] = String(hilbertViewModel.hilbertMatrix[i][j])
                        }
                    }
                    equations.copyElements(newObject: tempEquations)
                    
                    //
                    
                    // Update the system object
                    let tempGauss = Gauss(neq: self.numEqs)
                    system.copyElements(newObject: tempGauss)
                    
                    
                }) {
                    Text("Submit")
                        .padding(.horizontal, 4)
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
                
                Button(action:{
                    self.showHilbert = false
                }) {
                    Text("Cancel")
                        .padding(.horizontal, 4)

                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
                
            }
        }
    }
}

struct HilbertView_Previews: PreviewProvider {
    static var previews: some View {
       
        HilbertView(equations: Equations(neq: 2), system: Gauss(neq: 2), showHilbert: .constant(false), hilbertSizeText: .constant(""),numEqsText: .constant("2"), numEqs: .constant(2),showEquationView: .constant(false),showVerification: .constant(false))
    }
}
