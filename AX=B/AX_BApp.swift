//
//  AX_BApp.swift
//  AX=B
//
//  Created by Joseph Jung on 3/5/22.
//

import SwiftUI

@main
struct AX_BApp: App {
    
    @State var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(numEqs:2, numEqsText: "2", equations: Equations(neq: 2), system: Gauss(neq: 2), isDarkMode: $isDarkMode)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
