//
//  AMatrixView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct AMatrixView: View {
    @ObservedObject var equations: Equations
//    @ObservedObject var system: Gauss
    var body: some View {
        
//                MARK: - A Matrix
        
            Group {  // A Matrix
                VStack(spacing: 0){
                    
                    Text("A")
                        .bold()
                    
                    
                    
                    ForEach(0..<self.equations.aMatrixText.count, id: \.self){
                        let i = $0
                        
                        HStack{
                            
//                            Spacer(minLength: 15)
                            
                            MatrixBracketView(side: "left",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count, bracketColor: .black)
                            
                            ForEach(0..<self.equations.aMatrixText.count, id: \.self) {
                                let j = $0
                                
                                
                                TextField(self.equations.aMatrixText[i][j], text: $equations.aMatrixText[i][j])
                                    .frame(width: 70, height: 20)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())//.padding()
                                    .font(.custom("Arial", size: 15))
                                    .fixedSize()
                                // check for valid number here
                                .foregroundColor(Double(self.equations.aMatrixText[i][j]) != nil ? Color.black : Color.red)
                                .colorScheme(.light)

                            }
                            MatrixBracketView(side: "right",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count, bracketColor: .black)
                        }
                        
                    }
                    
                }
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
                .keyboardType(.numbersAndPunctuation)
    }
}

struct AMatrixView_Previews: PreviewProvider {
    static var previews: some View {
        AMatrixView(equations: Equations(neq:2))
    }
}
