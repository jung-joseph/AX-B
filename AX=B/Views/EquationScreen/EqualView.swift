//
//  EqualView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/14/22.
//

import SwiftUI

struct EqualView: View {
    @ObservedObject var equations: Equations

    var body: some View {
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
    }
}

struct EqualView_Previews: PreviewProvider {
    static var previews: some View {
        EqualView(equations: Equations(neq: 2))
    }
}
