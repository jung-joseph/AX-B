//
//  SettingsView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/13/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var numSigFigs: String
    @Binding var showSettingsView: Bool
    @Binding var isDarkMode: Bool
    
    var body: some View {
        VStack {
            Text("Settings")
                .foregroundColor(Color.blue)
                .font(.title)
            
            HStack{
                Text("Number of Significant Figures in Solution Display: ")
                    .foregroundColor(Color.black)
                TextField("  ", text: $numSigFigs)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.custom("Arial", size: 15)).fixedSize()
                    .foregroundColor(Color.black)
                    .colorScheme(.light)
                    .keyboardType(.decimalPad)
            }
            HStack {
                Spacer()
                Text("Appearance Mode: ")
                    .foregroundColor(Color.black)

                Picker("Mode", selection: $isDarkMode) {
                    Text("Light")
                        .tag(false)
                    Text("Dark")
                        .tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .fixedSize()
                Spacer()
            }
            
            HStack {
                Button(action: {
                    self.showSettingsView = false
                    // check for validity of numSigFig and make sure it is >= 2
                    if let numDigits = Int(numSigFigs){
                        if numDigits > 1 && numDigits < 6 {
                            return
                        } else {
                            numSigFigs = "2"
                        }
                    } else {
                        numSigFigs = "4"
                    }
                    
                    
                   
                }) {
                    Text("Submit")
                        .padding(.horizontal, 4)
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()

                Button(action:{
                    self.showSettingsView = false
                }) {
                    Text("Cancel")
                        .padding(.horizontal, 4)

                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()

            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(numSigFigs: .constant("3"), showSettingsView: .constant(true), isDarkMode: .constant(false))
    }
}
