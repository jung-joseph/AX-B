//
//  AX_BApp.swift
//  AX=B
//
//  Created by Joseph Jung on 3/5/22.
//

import SwiftUI

@main
struct AX_BApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(numEqs:2, numEqsText: "2", equations: Equations(neq: 2), system: Gauss(neq: 2))
        }
    }
}
