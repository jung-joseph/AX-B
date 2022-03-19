//
//  EquationsView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/19/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import SwiftUI

struct EquationsView: View {
    var numEqs: Int
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    @State var showFileNamer = false
    @State var filename = ""
    
    @Binding var showEquationView: Bool
    @Binding var numSigFigs: String
    
    var body: some View {
        
        
        VStack{
            
            EquationScreen(equations: equations, system: system, numSigFigs: $numSigFigs)
            
            // solver message
            VStack(alignment:.leading){
            HStack(){
                Spacer()
                Text("Solver Messages: ")
                Text("\(self.system.solverMessage)").foregroundColor(.red)
                Spacer()
                Spacer()
            }
                HStack{
                    Spacer()
                if(self.system.kNum != "0"){
                    Text("Condition Number Estimate: \(self.system.kNum)")
                }
                    Spacer()
                    Spacer()
                }
            }
//            BottomSolveButtonSection(equations: equations, system: system, showFileNamer: $showFileNamer, filename: $filename, showEquationView: $showEquationView, numSigFigs: $numSigFigs)
            
            
            
        } // View VStack
        
        
    } // View
    
    
    
    
}

struct EquationsView_Previews: PreviewProvider {
    static var previews: some View {
        EquationsView(numEqs:2, equations: Equations(neq: 2), system: Gauss(neq: 2),showEquationView: .constant(true), numSigFigs: .constant("4"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


