//
//  BVectorView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct BVectorView: View {
    @ObservedObject var equations: Equations
    
    var body: some View {
        Group{
            VStack(spacing: 0) { // B Matrix
                Text("B ")
                    .bold()
                ForEach(0..<self.equations.bMatrixText.count) {
                    let i = $0
                    
                    HStack{
                        
                        MatrixBracketView(side: "left",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                        
                        TextField(self.equations.bMatrixText[i], text: self.$equations.bMatrixText[i])
                            .frame(width: 60, height: 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.custom("Arial", size: 15))
                            .fixedSize()
                            .foregroundColor(Double(self.equations.bMatrixText[i]) != nil ? Color.black : Color.red)
                            .colorScheme(.light)

                        MatrixBracketView(side: "right",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                    }
                }

            }
        }
        .keyboardType(.numbersAndPunctuation)
    }
}

struct BVectorView_Previews: PreviewProvider {
    static var previews: some View {
        BVectorView(equations: Equations(neq: 2))
    }
}
