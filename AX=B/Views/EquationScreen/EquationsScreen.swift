//
//  EquationsView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/19/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import SwiftUI

struct EquationsScreen: View {
    var numEqs: Int
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    @State var showFileNamer = false
    @State var filename = ""
    
    @Binding var showEquationView: Bool
    @Binding var numSigFigs: String
    
    var body: some View {
        
        
        VStack(){
            
            EquationView(equations: equations, system: system, numSigFigs: $numSigFigs)
            
            
            MessageView(system: system)
            Spacer()
        }
//        .background(.yellow)
//        .frame(width: 700, height: 400, alignment: .leading)
        
    }
}
struct EquationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EquationsScreen(numEqs:2, equations: Equations(neq: 2), system: Gauss(neq: 2),showEquationView: .constant(true), numSigFigs: .constant("4"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct MessageView: View {
    @ObservedObject var system: Gauss

    var body: some View {
        // solver message
        VStack(){
            HStack(alignment: .top){
                
                Text("Solver Messages: ")
                    .padding(EdgeInsets(top: 0.0,leading: 10, bottom: 0, trailing: 0))
                Spacer()
                Spacer()
                Spacer()
            }
            HStack{
//                Spacer(minLength: 50)
                Text("\(self.system.solverMessage)")
                    .foregroundColor(.red)
                    .padding(EdgeInsets(top: 0.0,leading: 15, bottom: 0, trailing: 0))
                Spacer()
                Spacer()
            }
            HStack{
                if(self.system.kNum != "0"){
//                if(self.system.kNum == "0"){
                    Text("K(A) Estimate: \(self.system.kNum)")
                        .foregroundColor(.red)
                        .padding(EdgeInsets(top: 0.0,leading: 15, bottom: 0, trailing: 0))

                }
                Spacer()
                                    Spacer()
            }
        }
        //            BottomSolveButtonSection(equations: equations, system: system, showFileNamer: $showFileNamer, filename: $filename, showEquationView: $showEquationView, numSigFigs: $numSigFigs)
        
        
        
    }
    
    
}




