//
//  AboutView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/6/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Binding var showAbout: Bool
    
    var body: some View {
        VStack {
            HStack{
                
                Button {
                    showAbout = false
                } label: {
                    Image(systemName:"chevron.left")
                        .resizable()
                        .frame(width: 18, height: 18, alignment: .topLeading)
                        .foregroundColor(.black)
                }
                
                
                .foregroundColor(Color.black)
                .padding()
                Spacer()
            }
            ScrollView() {
                VStack {
                    //
                    
                    HStack {
                        //                Text("About")
                        //                    .foregroundColor(Color.black)
                        //                    .font(.largeTitle)
                        //                    .bold()
                        //                    .padding(EdgeInsets(top: 50, leading: 25, bottom: 0, trailing: 0))
                        
                        Image(systemName: "a.square.fill")
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .topLeading)
                            .foregroundColor(.green)
                        Image(systemName: "x.square.fill")
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .topLeading)
                            .foregroundColor(.green)
                        Image(systemName: "equal.square.fill")
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .topLeading)
                            .foregroundColor(.green)
                        Image(systemName: "b.square.fill")
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .topLeading)
                            .foregroundColor(.green)
                        
                        
                        Spacer()
                    }
                    
                    VStack{
                        Text("Welcome and Why")
                            .foregroundColor(Color.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                        Text("Welcome to AX=B! If you downloaded this app, I know that you are not a typical iOS user! Perhaps you have also noticed as I have, that there appears to be a dearth of basic \"Engineering or Science\" tools for students or professionals in the App Store. I have also observed that most college engineering programs (with the notable exception of computer science programs such as Stanford's), do not teach their students how to create programs (or tools) for mobile devices. Therefore, in the spirit of providing useful tools and programming examples of iOS tools for students, I created this simultaneous linear equation solver app. This app is written using SwiftUI (not UIKit). Once I am assured that the major bugs have been found and the app is reasonably easy to use, I intend to make the xCode project available in GitHub.  I hope that you find this app useful. ")
                            .font( Font.system(size: 14))
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        
                        
                        
                        
                    }
                    
                    VStack{
                        Text("Usage")
                            .foregroundColor(Color.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 10))
                        
                        VStack {
                            Text("The actual app usage should be intuitive, but some guidance may be useful. The user may either initiate a completely new problem or read-in a problem that he/she had previously entered and saved. Saved problems and saved solutions are stored in Files App on iOS devices in JSON format and is therefore user readable, should the user wish to do so. Once the problem has been entered (the coefficients of the A matrix and B vector are defined), any one of three solution algorithms may be used. All three algorithms are variants of Gauss elimination with back substituion (1). I included three algorithms to allow the user to explore how these variants perform for different types of problems. The algorithms are Gauss Elimination with no row interchanges(No Pivoting), Gauss Elimination with Maximal Column Pivoting, and Gauss Elimination with Scaled Column Pivoting. To assist the user in evaluating the performance of the different algorithms and the quality of the solution, a Residual vector (the difference of each equation's specified B value and each equation's computed right hand side value based on the computed solution) is given. In general, the Scaled Column Pivoting algorithm is considered to be the most robust in working with poorly conditioned equation systems (1). An estimate of the A matrice's condition number, K, is also given as part of the solution process. The A, B and solution vector may also be saved for subsequent use. If you are unfamilar with the matrix form of simultaneous equations, I refer you to Reference 2.")
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            
                            Text(" ")
                            
                            Text("The user is encouraged to use the problems found in the \"Verification Problems\" section for examples of usage. For the adventurous user, a capability that generates much studied Hilbert matrices, Reference 3, is included.")
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            
                            
                        }
                        
                        
                    }
                    
                    VStack{
                        Text("Caution and Disclaimer")
                            .foregroundColor(Color.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                        Text("Of course, there cannot be a guarentee that any given numerical algorithm will always \"work.\"  Moreover, even though the implimentations have been extensively tested, I do not assume any responsibility for the results or the usage of the results of this software. The user is reminded to always exam the \"Residual\" vector, as it provides a quantitative check of the accuracy of the numerical solution.")
                            .font( Font.system(size: 14))
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        
                    }
                    
                    VStack{
                        Text("References")
                            .foregroundColor(Color.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                        VStack(alignment: .leading) {
                            //                        HStack{
                            Text("1. Burden, Richard and Faires, J. Douglas; Numerical Analysis (third edition); Prindle, Weber & Schmit, Boston, 1985.")
                                .font( Font.system(size: 14))
                                .foregroundColor(Color.black)

                            
                            Text("2. AX=B matrix form; https://www.freetext.org/Introduction_to_Linear_Algebra/Systems_Linear_Equations/Ax_Equals_b/")
                                .font( Font.system(size: 14))
                                .foregroundColor(Color.black)
//                             
//                            Text("3. 3x3 Round-Off Verification Problem; https://www.rajgunesh.com/resources/downloads/numerical/gaussianelimination.pdf")
//                                .font( Font.system(size: 14))
//                                .foregroundColor(Color.black)

                            
                            //                            Spacer()
                            //                        }
                            Text("3. Hilbert Matrices; https://nhigham.com/2020/06/30/what-is-the-hilbert-matrix/")
                                .font( Font.system(size: 14))
                                .foregroundColor(Color.black)
                        }
                    }
                    VStack{
                        Text("Acknowledgment")
                            .foregroundColor(Color.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                        Text("Special words of appreciation for Dale Moseley, David Womble, Joseph Bishop, and Clarizza Morales are warranted. Dale's, David's, Joseph's, and Clarizza's review comments helped to make this app much more robust and user friendly.")
                            .font( Font.system(size: 14))
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        
                    }
                    Spacer()
                    Spacer()
                }
            }// Scroll View
        }// VStack
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutView(showAbout: .constant(true))
                .previewInterfaceOrientation(.portrait)
            
        }
    }
}
