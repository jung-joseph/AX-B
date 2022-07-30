//
//  Gauss.swift
//
//
//  Created by Joseph Jung on 4/23/20.
//

import Foundation


class Gauss: ObservableObject {
    
    var neq: Int
    var matrix = [[Double]]() // create an empty matrix
    @Published var matrixCopy = [[Double]]()
    @Published var bCopy = [Double]()
    
    
    @Published var x = [Double]()
    @Published var error = [Double]()
    @Published var solverMessage: String = ""
    @Published var kNum: String = "0"
    
    init(neq: Int) {
        
        solverMessage = "Initializing a new system of \(neq) equations"
        self.neq = neq
        
        matrix = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        matrixCopy = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        bCopy = Array(repeating: 0.0, count: neq)
        
        x = Array(repeating: 0.0, count: neq)
        
        error = Array(repeating: 0.0, count: neq)
        
        
        
        
    }
    
    //MARK: - Object copy
    func copyElements(newObject: Gauss) {
        
        self.neq = newObject.neq
        self.matrix = newObject.matrix
        self.matrixCopy = newObject.matrixCopy
        self.bCopy = newObject.bCopy
        self.x = newObject.x
        self.error = newObject.error
        self.solverMessage = newObject.solverMessage
        
    }
    
    
    func printGaussObject(){
        print("Gauss Object")
        print("neq: \(neq)")
        self.printAMatrix()
        self.printMatrixCopy()
        self.printBVector()
        self.printBCopy()
        self.printX()
        self.printError()
        print("solver message \(self.solverMessage)")
        printX()
        
    }
    //MARK: - printAMatrix

    func printAMatrix() {
        print("The (augmented) A Matrix")
        
        for array in matrix {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        
        
        print()
    }
    
    
    func printMatrixCopy() {
        print("Matrix Copy")
        
        for array in matrixCopy {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        
        
        print()
    }
    func printBVector() {
        print("B Vector (of Augmented Matix)")
        for i in 0...neq - 1 {
            
            print(" \(matrix[i][neq])")
        }
        print()
    }
    
    func printBCopy() {
        print("The B Matrix Copy")
        
        for value in bCopy {
            print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printX() {
        print("The X Matrix")
        
        for value in x {
            print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printError() {
        print("The Error")
        
        for value in error {
            print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    
    
    
 //MARK: - Scaled Column Pivoting
    @discardableResult func gaussSCPSolve() -> Bool {
        // Gauss Elimination with Scaled Column Pivoting
        // Burden, Richard, Faires, J. Douglas, "Numerical Analysis", Third Ed., 1985
        
        var factor: Double
        
        var sum : Double
        var product : Double
        var nCopy: Int
        let smallNumber: Double = 1.0e-15
        var nRow:[Int] = Array(repeating: 0, count: neq)
        var s:[Double] = Array(repeating: 0.0, count: neq)
        
        
        // copy original matrix for later error calculations
        for i in 0..<neq {
            for j in 0..<neq {
                matrixCopy[i][j] = matrix[i][j]
            }
            bCopy[i] = matrix[i][neq]
        }
        
        
        // deal with only 1 equation
        if neq == 1 {
            if abs(matrix[0][0]) < smallNumber {
                x[0] = 0.0
                solverMessage = "SCPSolve: Poorly Conditioned System - Zero or Near Zero Pivot"
                return false
            }
            x[0] = matrix[0][neq]/matrix[0][0]
            solverMessage = "SCPSolve: Solution Found"
            
            //            residual()
            
            return true
        }
        
        // Initialize Row Pointer
        
        for i in 0..<neq {
            s[i] = 0.0
            for j in 0..<neq {
                if abs(matrix[i][j]) > s[i] {
                    s[i] = abs(matrix[i][j])
                }
                
            }
            if s[i] == 0.0 {
                solverMessage = "SCPSolve: No Unique Solution Exist"
                return false
            }
            nRow[i] = i
        }
        
        // Forward Elimination
        for i in 0...neq-2 {
            
            var p = i
            var maxInCol = abs(matrix[nRow[i]][i])/s[nRow[i]]
            
            for j in i..<neq {
                if abs(matrix[nRow[j]][i])/s[nRow[j]] > maxInCol {
                    p = j
                    maxInCol = abs(matrix[nRow[j]][i])
                }
            }
            
            if(maxInCol < smallNumber) {
                solverMessage = "SCPSolve: No Unique Solution"
                return false
            }
            
            if(nRow[i] != nRow[p]) {
                nCopy = nRow[i]
                nRow[i] = nRow[p]
                nRow[p] = nCopy
            }
            
            
            for j in i+1...neq-1 {
                
                factor = matrix[nRow[j]][i]/matrix[nRow[i]][i]
                
                for jj in i...neq {
                    matrix[nRow[j]][jj] = matrix[nRow[j]][jj] - factor *  matrix[nRow[i]][jj]
                }
                
            }
            
        }
        
        if abs(matrix[nRow[neq-1]][neq-1]) < smallNumber {
            solverMessage = "SCPSolve: No Unique Solution"
            return false
        }
        
        // Back Substituion
        
        x[neq-1] = matrix[nRow[neq-1]][neq]/matrix[nRow[neq-1]][neq-1]
        
        
        for i in stride(from: neq-2, through: 0, by: -1){
            sum = 0.0
            for j in i+1...neq-1 {
                product = matrix[nRow[i]][j] * x[j]
                sum = sum - product
            }
            x[i] = (matrix[nRow[i]][neq] + sum)/matrix[nRow[i]][i]
            
        }
        
        
        
        solverMessage = "SCPSolve: Solution Found"
        //        residual()
        return true
    }
    
 //MARK: - Max Column Pivoting
    
    @discardableResult func gaussMCPSolve() -> Bool {
        // Gauss Elimination with Maximal Column Pivoting
        // Burden, Richard, Faires, J. Douglas, "Numerical Analysis", Third Ed., 1985
        
        var factor: Double
        
        var sum : Double
        var product : Double
        var nCopy: Int
        let smallNumber: Double = 1.0e-15
        var nRow:[Int] = Array(repeating: 0, count: neq)
        
        
        // copy original matrix for later error calculations
        for i in 0..<neq {
            for j in 0..<neq {
                matrixCopy[i][j] = matrix[i][j]
            }
            bCopy[i] = matrix[i][neq]
        }
        
        
        // deal with only 1 equation
        if neq == 1 {
            if abs(matrix[0][0]) < smallNumber {
                x[0] = 0.0
                solverMessage = "MCPSolve: Poorly Conditioned System - Zero or Near Zero Pivot"
                return false
            }
            x[0] = matrix[0][neq]/matrix[0][0]
            solverMessage = "MCPSolve: Solution Found"
            //            residual()
            return true
        }
        
        // Initialize Row Pointer
        
        for i in 0..<neq {
            nRow[i] = i
        }
        
        // Forward Elimination
        for i in 0...neq-2 {
            
            var p = i
            var maxInCol = abs(matrix[nRow[i]][i])
            
            for j in i..<neq {
                if abs(matrix[nRow[j]][i]) > maxInCol {
                    p = j
                    maxInCol = abs(matrix[nRow[j]][i])
                }
            }
            
            if(maxInCol < smallNumber) {
                solverMessage = "MCPSolve: No Unique Solution"
                return false
            }
            
            if(nRow[i] != nRow[p]) {
                nCopy = nRow[i]
                nRow[i] = nRow[p]
                nRow[p] = nCopy
            }
            
            
            for j in i+1...neq-1 {
                
                factor = matrix[nRow[j]][i]/matrix[nRow[i]][i]
                
                for jj in i...neq {
                    matrix[nRow[j]][jj] = matrix[nRow[j]][jj] - factor *  matrix[nRow[i]][jj]
                }
                
            }
            
        }
        
        if abs(matrix[nRow[neq-1]][neq-1]) < smallNumber {
            solverMessage = "MCPSolve: No Unique Solution"
            return false
        }
        
        // Back Substituion
        
        x[neq-1] = matrix[nRow[neq-1]][neq]/matrix[nRow[neq-1]][neq-1]
        
        
        for i in stride(from: neq-2, through: 0, by: -1){
            sum = 0.0
            for j in i+1...neq-1 {
                product = matrix[nRow[i]][j] * x[j]
                sum = sum - product
            }
            x[i] = (matrix[nRow[i]][neq] + sum)/matrix[nRow[i]][i]
            
        }
        
        
        
        solverMessage = "MCPSolve: Solution Found"
        //        residual()
        return true
    }
    
    
    //MARK: - Gauss Elimination without pivoting
    
    @discardableResult func gaussSolve() -> Bool {
        
        var factor: Double
        
        var sum : Double
        var product : Double
        let smallNumber: Double = 1.0e-15
        var nRow:[Int] = Array(repeating: 0, count: neq)
        //        var nCopy: Int
        
        // copy original matrix for later error calculations
        for i in 0..<neq {
            for j in 0..<neq {
                //                print("gaussSolve \(i) \(j)")
                matrixCopy[i][j] = matrix[i][j]
            }
            bCopy[i] = matrix[i][neq]
        }
        
        // deal with only 1 equation
        if neq == 1 {
            if abs(matrix[0][0]) < smallNumber {
                x[0] = 0.0
                solverMessage = "GaussSolve: Poorly Conditioned System - Zero or Near Zero Pivot"
                return false
            }
            x[0] = matrix[0][neq]/matrix[0][0]
            solverMessage = "GaussSolve: Solution Found"
            //            residual()
            return true
        }
        
        
        // Initialize Row Pointer
        
        for i in 0..<neq {
            nRow[i] = i
        }
        
        // Forward Elimination
        
        for i in 0...neq-2 {
            
            var p = -1
            for j in i..<neq {
                //                for j in i..<neq {
                
                if abs(matrix[nRow[j]][i]) > smallNumber {
                    p = j
                    break
                }
            }
            if(p == -1) {
                solverMessage = "GaussSolve: No Unique Solution or Possible Poorly Conditioned System"
                return false
            }
            
            //                // Perform row interchange, if necessary
            //                if p != i {
            ////                    print("Gauss: interchanging rows \(p) for \(i)")
            //                    nCopy = nRow[i]
            //                    nRow[i] = nRow[p]
            //                    nRow[p] = nCopy
            //                }
            
            for j in i+1...neq-1 {
                
                if abs(matrix[nRow[i]][i]) < smallNumber {
                    solverMessage = "GaussSolve: Poorly Conditioned System - Zero or Near Zero Pivot"
                    return false
                }
                factor = matrix[nRow[j]][i]/matrix[nRow[i]][i]
                for jj in i...neq {
                    matrix[nRow[j]][jj] = matrix[nRow[j]][jj] - (factor *  matrix[nRow[i]][jj])
                }
                
            }
        }
        
        if abs(matrix[nRow[neq-1]][neq-1]) < smallNumber {
            solverMessage = "GaussSolve: No Unique Solution - Zero in Last Pivot"
            return false
        }
        
        // Back Substituion
        
        x[neq-1] = matrix[nRow[neq-1]][neq]/matrix[nRow[neq-1]][neq-1]
        
        
        for i in stride(from: neq-2, through: 0, by: -1){
            sum = 0.0
            for j in i+1...neq-1 {
                product = matrix[nRow[i]][j] * x[j]
                sum = sum - product
            }
            x[i] = (matrix[nRow[i]][neq] + sum)/matrix[nRow[i]][i]
        }
        
        solverMessage = "GaussSolve: Solution Found"
        //        residual()
        return true
    }
    
    func printSolution(){
        print("Solution vector")
        print(" i   x[i]")
        
        for i in 0...neq-1 {
            print("\(i)     \(x[i])")
        }
    }
    func printSolverMessage(){
        print("\n\(solverMessage)\n")
    }
    
    @discardableResult func residual()-> [Double]  {
        
        
        for i in 0...neq - 1{
            error[i] = 0.0
            for j in 0..<neq {
                error[i] = error[i] + matrixCopy[i][j] * x[j]
            }
            error[i] = bCopy[i] - error[i]
        }
        
        return error
    }
    
    //MARK: - CONDITION NUMBER
        
    func CondNum(neq: Int,  originalSystem: Gauss, eigenSystem: Gauss, maxIt: Int, tolerance: Double)-> String {
            var max:Double = 0.0
            var min:Double = 1.0
            var rowSum:Double = 0.0

            
  
            
            for i in 0..<neq {
                rowSum = 0.0
                for j in 0..<neq {
                    if i != j {
                        rowSum = rowSum + abs(originalSystem.matrix[i][j])
                    }
                    
                    
                    
                }
                if max < abs(originalSystem.matrix[i][i]) + rowSum {
                    max = abs(originalSystem.matrix[i][i]) + rowSum
                }
                if min > abs(originalSystem.matrix[i][i]) - rowSum {
                    min = abs(originalSystem.matrix[i][i]) - rowSum
                    if min < 0.0 {
                        min = 0.0
                    }
                }
               
            }
            
            
        
        let bk0 = Array(repeating: 1.0, count: neq)
        min = eigenSystem.inversePower(originalSystem: originalSystem, bk0: bk0, lamda0: 0.0, maxIt: maxIt, itDiffTol: tolerance)

//        print("max: \(max) min: \(min)")
        
        
        if abs(min) < 1.0e-15 {
            kNum = "Infinity"
        } else {
            kNum = String(format:"%.1e",max/min)
            }
            
            return kNum
        }
        
        // MARK: - Vector Inf Norm
        
        func vectorInfNorm(vector: [Double])-> Double {
            var norm = 0.0
            var value:Double = 0.0
            for i in 0..<vector.count {
                value = abs(vector[i])
                if norm < value {
                    norm = value
                }
            }
            return value
        }
        //MARK: - Inverse Power Method
        func inversePower(originalSystem: Gauss, bk0:[Double], lamda0: Double, maxIt: Int, itDiffTol: Double)-> Double {
            
            // matrix: A matrix
            // bk: Intial EigenVector guess
            // lamda: Intial eigenvalue guess
            // maxIt: maximum number of inversePower iterations
            // tol: percentage difference for iteration to end
            
            var ck = 1.0
            var iteration: Int = 0
            var itDiff: Double = 10.0
            var lamda:Double = lamda0
            var bk = Array(repeating: 0.0, count: neq)
            var lamdaOld:Double = lamda0 //set and initialize
            
            
            
            
            // initalize the rhs
            for i in 0..<neq {
                bk[i] = bk0[i]
            }
            
            
            while iteration < maxIt && itDiff > itDiffTol {
                
                iteration += 1
                
                
                // form (A - lamda I) and load rhs
                for ii in 0..<neq {
                    for jj in 0..<neq {
                        self.matrix[ii][jj] = originalSystem.matrix[ii][jj]
                    }
                    self.matrix[ii][ii] = self.matrix[ii][ii] - lamda0

                    self.matrix[ii][neq] = bk[ii]
                }
               
                
                // solve for next bk
                self.gaussSCPSolve()
                // update bk
                for ii in 0..<neq {
                    bk[ii] = self.x[ii]
                }
                // find ck
                var minValue = 0.0
                var saveIndex = 0
                for ii in 0..<neq {
                    if abs(bk[ii]) > minValue {
                        saveIndex = ii
                        minValue = abs(bk[ii])
                    }
                }
                ck = bk[saveIndex]
                
                // normalize bk and fill rhs
                for ii in 0..<neq {
                    bk[ii] = bk[ii]/ck
                }
                // perform Rayleigh Quotient for eigenvalue
                
                lamda = abs(rayleighQuotient(matrix: originalSystem.matrix, b: bk))
                // check iteration diff
                itDiff = 100.0 * abs(lamda - lamdaOld)/lamda
                lamdaOld = lamda
            }
            
   
//            print("lamda  in Power \(lamda)")
            return lamda
        }

       //MARK: - Rayleigh Quotient
        
        func rayleighQuotient(matrix:[[Double]], b:[Double]) -> Double {
            
            var productVect = [Double](repeating: 0.0, count: b.count)
            
            productVect = matMulVector(matrix: matrix, vector: b)
            
            let numerator = vectMulVect(vect1: b, vect2: productVect)
            
            let denominator = vectMulVect(vect1: b, vect2: b)
            
            if denominator == 0.0 {
                print("denominator is 0.0")
                return 0.0
            }
            var rayleighQ:Double = 0.0
            let numIsNan = numerator.isNaN
            let denoIsNan = denominator.isNaN
            if numIsNan || denoIsNan {
                rayleighQ = 0.0
            } else {
                rayleighQ = numerator/denominator
            }
            

            return rayleighQ
            
        }
        
        func matMulVector(matrix:[[Double]], vector:[Double])-> [Double] {
            var sum: Double
            var result = [Double](repeating: 0.0, count: vector.count)
            
            for i in 0..<vector.count {
                sum = 0.0
                for j in 0..<vector.count {
                    sum = sum + matrix[i][j] * vector[j]
                }
                result[i] = sum
            }
            return result
        }
        
        func vectMulVect(vect1:[Double], vect2:[Double]) -> Double {
            
            var sum = 0.0
            
            if vect1.count != vect2.count {
                print("Vectors not the same length")
                return 0.0
            }
            for i in 0..<vect1.count {
                sum = sum + vect1[i] * vect2[i]
            }
            return sum
        }
//    func kNumber(residualSolutionVector: [Double], xSolutionVector: [Double]){
////        compute an estimate for the Condition Number of a Matrix
//
//        kNum = "0"
//
//        let t = 15.0 // Double precision number
//
//        let rSVNorm = vectorInfNorm(vector: residualSolutionVector)
//        print("\(rSVNorm)")
//        let xSVNorm = vectorInfNorm(vector: xSolutionVector)
//        print("\(xSVNorm)")
//
//        if xSVNorm == 0.0 {
//            kNum = "Unable to compute"
//
//        } else {
//            kNum = String(Int(pow(10.0,t) * (rSVNorm / xSVNorm)))
//
//        }
//    }
//
//    func vectorInfNorm(vector: [Double])-> Double {
//        var norm = 0.0
//        var value:Double = 0.0
//        for i in 0..<vector.count {
//            value = abs(vector[i])
//            if norm < value {
//                norm = value
//            }
//        }
//        return value
//    }
//
//    func kNumGCircles() {
//        var max:Double = 0.0
//        var min:Double = 1.0
//        var rowSum:Double = 0.0
//
//        for i in 0..<matrix.count {
//            rowSum = 0.0
//            for j in 0..<matrix.count {
//                if i != j {
//                    rowSum = rowSum + abs(matrix[i][j])
//                }
//
//
//
//            }
//            if max < abs(matrix[i][i]) + rowSum {
//                max = abs(matrix[i][i]) + rowSum
//            }
//            if min > abs(matrix[i][i]) - rowSum {
//                min = abs(matrix[i][i]) - rowSum
//                if min < 0.0 {
//                    min = 0.0
//                }
//            }
//
//        }
//
//        if min == 0.0 {
//            kNum = "Infinity (or potentially large)"
//        } else {
//            kNum = String(Int(max/min))
//        }
//    }
    
}

