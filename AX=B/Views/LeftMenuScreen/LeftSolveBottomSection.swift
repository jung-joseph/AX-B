//
//  LeftSolveBottomSection.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct LeftSolveButtonSection: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @Binding var showFileNamer: Bool
    @Binding var filename: String
    @Binding var showEquationView: Bool
    @Binding var numSigFigs: String
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Select Solution Method:").padding(.bottom, 1)
//            Text("Method:").padding(.bottom, 1)

            //MARK: - Gauss Elimination
            Button(action: {
                
                hideKeyboard()
                
                showEquationView = false
                
                equations.blankXEText() // blank out x and error texts
                
                
                let errorCode = transferTextToDouble(equations: equations, system: system)
                if errorCode {
                    system.solverMessage = "Invalid Entry"
                    self.showEquationView = true
                    return
                }
                
// Estimate Matrix Condition number here, before solve
                
                system.kNumGCircles()

                
                
                let success = self.system.gaussSolve()

                
                if success { // copy solution to Text
                    system.residual()
                    solutionToText(equations: equations, system: system, numSigFigs: numSigFigs)
                    
                      
                }
                
                showEquationView = true
                
            }) {
                Text("No Pivoting")
                    .padding(.horizontal, 4)
                
            }.background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.bottom, 5)
            
            //MARK: - Gauss Elimination with Maximal Column Pivoting
            Button(action: {
                
                hideKeyboard()
                
                showEquationView = false
                
                equations.blankXEText() // blank out x and error texts
                
                
                let errorCode = transferTextToDouble(equations: equations, system: system)
                if errorCode {
                    system.solverMessage = "Invalid Entry"
                    self.showEquationView = true
                    return
                }
                
                // Estimate Matrix Condition number here, before solve
                                
                                system.kNumGCircles()
                
                
                let success = self.system.gaussMCPSolve()

                
                if success { // copy solution to Text
                    
                    system.residual()
                    solutionToText(equations: equations, system: system, numSigFigs: numSigFigs)
                    
                    
                }
                
                showEquationView = true
                
            }) {
                Text("Maximal Column Pivot")
                    .padding(.horizontal, 4)
                
            }.background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.bottom, 5)
            
            
            // MARK: - Scaled Column Piviot
            Button(action: {
                
                hideKeyboard()
                
                showEquationView = false
                
                equations.blankXEText() // blank out x and error texts
                
                let errorCode = transferTextToDouble(equations: equations, system: system)
                if errorCode {
                    system.solverMessage = "Invalid Entry"
                    self.showEquationView = true
                    return
                }
                // Estimate Matrix Condition number here, before solve
                                
                                system.kNumGCircles()
                
                let success = self.system.gaussSCPSolve()
                
                //
                // write solution and error to Text
                if success {
                    // copy solution to Text
                    system.residual()
                    solutionToText(equations: equations, system: system, numSigFigs: numSigFigs)

                    let errorCode = transferTextToDouble(equations: equations, system: system)
                    if errorCode {
                        system.solverMessage = "Invalid Entry"
                        self.showEquationView = true
                        return
                    }
                    
                    
                }
                showEquationView = true
                
                
            }) {
                Text("Scaled Column Pivot")
                    .padding(.horizontal, 4)
                
            }.background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.bottom, 15)
            
            
          
            
//            Image(systemName: "arrow.down")
//                .resizable()
//                .frame(width: 15, height: 15, alignment: .topLeading)
//                .foregroundColor(.black)
            
            //MARK: - Write File
            
            Text("Save Work (optional):")
            
            Button(action: {
                
                showFileNamer = true
                filename = ""
                
            }) {
                Text("Save Problem")
                    .padding(.horizontal, 4)
                
            }
            .sheet(isPresented: $showFileNamer) {
                
                FileNamer(fileName: self.$filename, showFileNamer: self.$showFileNamer)
                
                    .onDisappear {
                        let encodedData = try! JSONEncoder().encode(self.equations)
                        let tempEncodedData = String(data: encodedData, encoding: .utf8)!
                        print("in Write File")
                        print(tempEncodedData)
                        // Write to Files App
                        system.solverMessage = writeTextFile( fileName: filename, contents: tempEncodedData)
                    }
            }
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 5)

            
            
            
            
            //MARK: - Write Solution Vector
            
            Button {
                showFileNamer = true
                filename = ""
                
            } label: {
                Text("Save Solution")
                    .padding(.horizontal, 4)
                
            }
            .sheet(isPresented: $showFileNamer) {
                FileNamer(fileName: self.$filename, showFileNamer: self.$showFileNamer)
                
                    .onDisappear {
                        var solutionVector = [Double]()
                        //                            print("self.numEqs \(self.numEqs)")
                        for i in 0..<equations.neq {
                            solutionVector.append(Double(self.equations.xMatrixText[i]) ?? 0.0)
                        }
                        //
                        
                        
                        let encodedData = try! JSONEncoder().encode(solutionVector)
                        let tempEncodedData = String(data: encodedData, encoding: .utf8)!
                        
                        //                             Write to Files App
                        system.solverMessage = writeTextFile( fileName: filename, contents: tempEncodedData)
                        
                        
                    }
            }
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
//            .padding()
            
            
        }
    }
}

struct LeftSolveButtonSection_Previews: PreviewProvider {
    static var previews: some View {
        LeftSolveButtonSection(equations: Equations(neq: 1), system: Gauss(neq: 1), showFileNamer: .constant(false), filename: .constant(""), showEquationView: .constant(true), numSigFigs: .constant("4"))
            .previewInterfaceOrientation(.landscapeRight)
    }
}

