//
//  EquationSection.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/8/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct EquationSection: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @Binding var numSigFigs: String
    
    var body: some View {
       
            HStack{
//                MARK: - A Matrix
                Group {  // A Matrix
                    VStack(spacing: 0){
                        
                        Text("A")
                            .bold()
                        
                        
                        
                        ForEach(0..<self.equations.aMatrixText.count){
                            let i = $0
                            
                            HStack{
                                
                                MatrixBracketView(side: "left",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                                
                                ForEach(0..<self.equations.aMatrixText.count) {
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
                                MatrixBracketView(side: "right",  rowHeight: 50, indexI: i, count: self.equations.aMatrixText.count)
                            }
                            
                        }
                        
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
                
                
                //                MARK: - *

//                Group{ // *
//                    VStack{
//                        Text("")
//
//                        ForEach(equations.fillerStarVector, id: \.self) { element in
//                            Text("\(element)")
//                        }
//                        //                        Text("*")
//                        Image(systemName: "multiply")
//                            .resizable()
//                            .frame(width: 10, height: 10)
//                    }
//                }
                
                
                //                MARK: - X Matrix

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
                

//                MARK: - =
                Group{ // =
                    VStack{ // =
                        Text("")
                        
                        ForEach(equations.fillerEqualVector, id: \.self) { element in
                            Text("\(element)")
                        }
                        //                        Text("=")
                        Image(systemName: "equal")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }
                }
                
                
                //                MARK: - B Matrix

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
                
                
//  MARK: - Error
                Group { // Error
                    VStack(spacing: 0){
                        Text("Error")
                            .bold()
                        
                        ForEach(0..<self.system.error.count) {
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
                
                
                
                
            } // HStack for Equations
            .keyboardType(.numbersAndPunctuation)

      
    }
}



struct EquationSection_Previews: PreviewProvider {
    static var previews: some View {
            EquationSection(equations: Equations(neq: 2), system: Gauss(neq: 2), numSigFigs: .constant("4"))
            
       
    }
}
