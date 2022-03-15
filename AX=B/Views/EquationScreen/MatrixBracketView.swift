//
//  MatrixBracketView.swift
//  AX=B
//
//  Created by Joseph Jung on 3/13/22.
//

import SwiftUI

struct MatrixBracketView: View {
    
    var side: String = "left"
    var rowHeight: CGFloat = 50
    var indexI: Int = 0
    var count: Int = 0
    
    var body: some View {
        
        if side == "left" { //Left
            if indexI == 0 && indexI == count - 1 {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle().frame(width: 5, height: 3)
                    Rectangle().frame(width: 3, height: rowHeight)
                    Rectangle().frame(width: 5, height: 3).offset(x: 0)
                }
            }else if indexI == 0 { //top
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle().frame(width: 5, height: 3)
                    Rectangle().frame(width: 3, height: rowHeight)
                }
            } else if indexI == count - 1 { //bottom
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle().frame(width: 3, height: rowHeight).offset(x: 0)
                    Rectangle().frame(width: 5, height: 3).offset(x: 0)
                }
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle().frame(width: 3, height: rowHeight).offset(x: -2)
                }
            }
        } else if side == "right" { // right
            if indexI == 0 && indexI == count - 1 {
                VStack(alignment: .trailing, spacing: 0) {
                    Rectangle().frame(width: 5, height: 3)
                    Rectangle().frame(width: 3, height: rowHeight)
                    Rectangle().frame(width: 5, height: 3).offset(x: 0)

                }
            }else if indexI == 0 {
                VStack(alignment: .trailing, spacing: 0) {
                    Rectangle().frame(width: 5, height: 3)
                    Rectangle().frame(width: 3, height: rowHeight)
                }
            } else if indexI == count - 1 {
                VStack(alignment: .trailing, spacing: 0) {
                    Rectangle().frame(width: 3, height: rowHeight).offset(x: 0)
                    Rectangle().frame(width: 5, height: 3).offset(x: 0)
                }
            } else {
                VStack(alignment: .trailing, spacing: 0) {
                    Rectangle().frame(width: 3, height: rowHeight).offset(x: +2)
                }
            }

        }
    }
}

struct MatrixBracketView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixBracketView()
    }
}
