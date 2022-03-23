//
//  EquationScreen.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/8/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct EquationView: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @Binding var numSigFigs: String
    
    var body: some View {
        
        HStack{
            
            //MARK: - A Matrix
            
            AMatrixView(equations: equations)
               

            
            //                MARK: - X Vector
            
            XVectorView(equations: equations)
            
            
            //                MARK: - =
            EqualView(equations: equations)

                
                
                //                MARK: - B Matrix

               BVectorView(equations: equations)
                
                
//  MARK: - Error
                ErrorView(equations: equations, system: system)
                
                
 //MARK: - END Matrices
                
                
            } // HStack for Equations
            

      
    }
}



struct EquationView_Previews: PreviewProvider {
    static var previews: some View {
            EquationView(equations: Equations(neq: 2), system: Gauss(neq: 2), numSigFigs: .constant("4"))
            
       
    }
}
