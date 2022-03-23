//
//  ErrorView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    var body: some View {
        Group { // Error
            VStack(spacing: 0){
                
                        Text("Residual")
                            .bold()
                
                ForEach(0..<self.system.error.count, id: \.self) {
                    let i = $0

                    HStack{

                        MatrixBracketView(side: "left",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)

                        Text("\(self.equations.errorText[i])")
                            .frame(width: 80, height: 20)
                            .font(.custom("Arial", size: 15))
                            .fixedSize()

                        MatrixBracketView(side: "right",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                    }
                }
                
                
            }
            
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(equations: Equations(neq: 2),system: Gauss(neq: 2))
    }
}
