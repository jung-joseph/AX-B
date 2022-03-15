//
//  LeftMenuView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/9/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LeftMenuView: View {
    @Binding var showAbout: Bool
    @Binding var showNewProblem: Bool
    @Binding var showVerification: Bool
    @Binding var showEquationView: Bool
    @Binding var neqText: String
    @Binding var showDocumentPicker: Bool
    @Binding var readFileContent: String
    @Binding var numEqsText: String
    @Binding var numEqs: Int
    @Binding var showSettingsView: Bool
    @Binding var numSigFigs: String
    @Binding var isDarkMode: Bool
    @Binding var showFileNamer: Bool
    @Binding var filename: String
    
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    var body: some View {
        VStack(alignment: .leading){
            
            
            // MARK:  - About
            Button{
                hideKeyboard()
                
                showAbout = true
            } label: {
                Text("About")
                    .padding(.horizontal, 4)
            }
            .sheet(isPresented: $showAbout) {
                AboutView(showAbout: self.$showAbout)
                    .preferredColorScheme(.light)
                    .onDisappear{
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 5)
            
            //MARK: - Settings
            Button(action:
                    {
                showSettingsView = true
                
            }) {
                Text("Settings")
                    .padding(.horizontal, 4)
                
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView(numSigFigs: $numSigFigs, showSettingsView: $showSettingsView, isDarkMode: $isDarkMode)
                
                    .onDisappear {
                        //                                    print("in Start New Problem")
                        
                        
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 5)
            
            //
            
            
            //MARK: - Left I/O Buttons
            
            LeftI_OButtons(neqText: $neqText, numEqsText: $numEqsText, numEqs: $numEqs, showNewProblem: $showNewProblem, readFileContent: $readFileContent, showVerification: $showVerification, showEquationView: $showEquationView, showDocumentPicker: $showDocumentPicker, equations: equations, system: system)
            
            
            //MARK: - Solver buttoms
            
            LeftSolveButtonSection(equations: equations, system: system, showFileNamer: $showFileNamer, filename: $filename, showEquationView: $showEquationView, numSigFigs: $numSigFigs)
            
            
            Spacer()
        } // VStack
    }
}

struct LeftMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuView(showAbout: .constant(false), showNewProblem: .constant(false), showVerification: .constant(false), showEquationView: .constant(false), neqText: .constant("2"), showDocumentPicker: .constant(false), readFileContent: .constant(" "), numEqsText: .constant("2"), numEqs: .constant(2), showSettingsView: .constant(false), numSigFigs: .constant("3"), isDarkMode: .constant(false),showFileNamer: .constant(false), filename: .constant(""), equations: Equations(neq: 2), system: Gauss(neq: 2))
    }
}
