//
//  XVectorView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct XVectorView: View {
    @ObservedObject var equations: Equations
    
    var body: some View {
        Group {
            
            VStack(spacing: 0) { // X Matrix
                Text("X")
                    .bold()
                
               
                   
                    
                    ForEach(0..<self.equations.xMatrixText.count) {
                        let i = $0
                        HStack {
                        MatrixBracketView(side: "left",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                        
                        Text("\(self.equations.xMatrixText[i])")
                                .frame(width: 90, height: 20)
                                .font(.custom("Arial", size: 15))
                                .fixedSize()
                        
                        MatrixBracketView(side: "right",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                        }
                    }
//                            .padding([.top, .bottom], 8)
                    
               
            }
            
        }
    }
}

struct XVectorView_Previews: PreviewProvider {
    static var previews: some View {
        XVectorView(equations: Equations(neq: 2))
    }
}
