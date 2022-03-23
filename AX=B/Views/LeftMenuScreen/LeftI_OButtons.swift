//
//  LeftI_OButtons.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct LeftI_OButtons: View {
    @Binding var neqText: String
    @Binding var numEqsText: String
    @Binding var numEqs: Int
    @Binding var showNewProblem: Bool
    @Binding var readFileContent: String
    @Binding var showVerification: Bool
    @Binding var showEquationView: Bool
    @Binding var showDocumentPicker: Bool

    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss

    var body: some View {
        VStack(alignment: .leading) {
            Text("Initiate Problem:")
            
            //MARK: - New Problem
            Button(action:
                    {
                showNewProblem = true
                showEquationView = false
                
                
            }) {
                Text("Start New Problem")
                    .padding(.horizontal, 4)
                
            }
            .sheet(isPresented: $showNewProblem) {
                NewProblemView(neqText: $neqText, showNewProblem: $showNewProblem,system: system)
                
                    .onDisappear {
                        //                                    print("in Start New Problem")
                        // create a new problem
                        self.numEqsText = neqText
                        self.numEqs = Int(self.numEqsText) ?? 0
                        self.showEquationView = true
                        // Update the equations object
                        let tempEquations = Equations(neq: self.numEqs)
                        equations.copyElements(newObject: tempEquations)
                        
                        //
                        
                        // Update the system object
                        let tempGauss = Gauss(neq: self.numEqs)
                        system.copyElements(newObject: tempGauss)
                        
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 1)
            
            //
            
            
            //MARK: - Load a Saved Problem
            
            Button(action: {
                
                //                        print(" in Read file")
                
                showDocumentPicker = true
                showEquationView = false
                
                
            }) {
                Text("Load a Saved Problem")
                    .padding(.horizontal, 4)
                
            }
            .sheet(isPresented: self.$showDocumentPicker) {
                
                DocumentPicker(fileContent: $readFileContent)
                    .onDisappear {
                        
                        
                        //
                        
                        let decoder = JSONDecoder()
                        do {
                            
                            //                                    decode the data from the file
                            let readInData = try decoder.decode(Equations.self, from: (readFileContent).data(using: .utf8)!)
                            
                            
                            self.numEqsText = String(readInData.neq)
                            self.numEqs = readInData.neq
                            
                            //
                            //copy read object into current equation object
                            //                            let tempEquations = Equations(neq: self.numEqs) // temp new equation object
                            self.showEquationView = true
                            
                            //                            equations.copyElements(newObject: tempEquations)
                            
                            equations.copyElements(newObject: readInData)
                            
                            equations.blankXEText()
                            
                            //
                            
                            // Update the system object
                            let tempGauss = Gauss(neq: self.numEqs)
                            system.copyElements(newObject: tempGauss)
                            
                            
                            
                            //
                            
                        } catch {
                            print ("Error in decodeJSON")
                            system.solverMessage = "Invalid file selected"
                            showEquationView = true
                            //                                    message = "Error in decodeJSON while reading file"
                            //                                    showMessage = true
                            
                            return
                        }
                    }
                
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 1)
            
            
            
            
            
            //MARK: - Load Verification Problems
            
            
            Button {
                showVerification = true
                showEquationView = false
            } label: {
                Text("Verification Problems")
                    .padding(.horizontal, 4)
            }
            .sheet(isPresented: $showVerification) {
                
                VerificationProblemsView(numEqs:$numEqs,numEqsText: $neqText,showVerification: $showVerification, showEquationView: $showEquationView, equations: equations, system: system)
                
                    .onDisappear {
                        showVerification = false
                        showEquationView = true
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 5)
            
            
//            Image(systemName: "arrow.down")
//                .resizable()
//                .frame(width: 15, height: 15, alignment: .topLeading)
//                .foregroundColor(.black)
        }
    }
}

struct LeftI_OButtons_Previews: PreviewProvider {
    static var previews: some View {
        LeftI_OButtons(neqText: .constant("2"), numEqsText: .constant("2"),numEqs: .constant(2),showNewProblem: .constant(false), readFileContent: .constant(""), showVerification: .constant(false), showEquationView: .constant(false), showDocumentPicker: .constant(false), equations: Equations(neq: 2), system: Gauss(neq: 2))
    }
}
