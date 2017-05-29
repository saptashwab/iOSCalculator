//
//  ViewController.swift
//  Calculator
//
//  Created by Saptashwa Bandyopadhyay on 05/05/17.
//  Copyright © 2017 Saptashwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isTyping = false
    var canInputDecimalPoint = true
    @IBOutlet weak var digit: UILabel!
    
    var displayVal: Double {
        get {
            if let dispText = Double(digit.text!) {
                return dispText
            }
            else {
                return 0.0
            }
        }
        set {
            digit.text = String(newValue)
        }
    }
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digitPressed = sender.currentTitle!
        if isTyping==false
        {
            isTyping = true
            canInputDecimalPoint = true
            if canInputDecimalPoint == true && digitPressed == "." {
                digit.text = "0" + digitPressed
                canInputDecimalPoint = false
            }
            else {
                digit.text = digitPressed
            }
        }
        else{
            if canInputDecimalPoint == true && digitPressed == "." {
                digit.text = digit.text! + digitPressed
                canInputDecimalPoint = false
            }
            
            if digitPressed != "." {
                digit.text = digit.text! + digitPressed
            }
            
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func operation(_ sender: UIButton) {
        isTyping = false
        canInputDecimalPoint = false
        
        brain.setOperand(displayVal)
        
        if let mathSymbol = sender.currentTitle {
            brain.doOperation(mathSymbol)
        }
        if let res = brain.result {
            displayVal = res
        }
    }
}

