//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Saptashwa Bandyopadhyay on 11/05/17.
//  Copyright © 2017 Saptashwa. All rights reserved.
//

import Foundation

struct CalculatorBrain  {
    
    private var accumulator: Double?
    
    var result:Double?  {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operation: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "±" : Operation.unaryOperation({ -$0 }),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "sin" : Operation.unaryOperation(sin),
        "ln" : Operation.unaryOperation(log),
        "log" : Operation.unaryOperation(log10),
        "×" : Operation.binaryOperation({ $0*$1 }),
        "+" : Operation.binaryOperation({ $0+$1 }),
        "-" : Operation.binaryOperation({ $0-$1 }),
        "÷" : Operation.binaryOperation({ $0/$1 }),
        "=" : Operation.equals
    ]
    
    mutating func doOperation(_ symbol: String) {
        if let opr = operation[symbol] {
            switch opr {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                }
            
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
        }
    }
    
    private var pbo: pendingBinaryOperation?
    
    private struct pendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
}
