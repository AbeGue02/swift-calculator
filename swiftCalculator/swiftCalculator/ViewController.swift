//
//  ViewController.swift
//  swiftCalculator
//
//  Created by Abraham Guerrero on 5/9/24.
//

import UIKit

class ViewController: UIViewController {

    enum Operation {
        case none
        case addition
        case subtraction
        case multiplication
        case division
    }
    
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var result: Double = 0
    var operation: Operation = .none
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func anyButtonPressed(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @IBAction func anyButtonPressedUp(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
    
        if resultLabel.text == "0" {
            resultLabel.text = sender.titleLabel?.text
        } else {
            resultLabel.text! += sender.titleLabel?.text ?? ""
        }
        
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if !(resultLabel.text?.contains(".") ?? false) {
            resultLabel.text? += "."
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
            case "÷":
                operation = .division
            case "x":
                operation = .multiplication
            case "-":
                operation = .subtraction
            case "+":
                operation = .addition
            default:
                print("There has been an unexpected error")
        }
        
        firstOperand = Double(resultLabel.text ?? "0") ?? 0
        resultLabel.text = "0"
        
    }
    
    @IBAction func changeSignButtonPressed(_ sender: UIButton) {
        if let text = resultLabel.text, let doubleValue = Double(text), doubleValue != 0.0 {
            if !text.hasPrefix("-") {
                resultLabel.text = "-\(text)"
            } else {
                resultLabel.text = String(text.dropFirst())
            }
        }
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if let text = resultLabel.text, let doubleValue = Double(text) {
            resultLabel.text = String(format: "%g", (doubleValue / 100))
        }
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        
        secondOperand = Double(resultLabel.text ?? "0") ?? 0
        
        switch operation {
            case .addition:
                result = (firstOperand + secondOperand)
            case .subtraction:
                result = (firstOperand - secondOperand)
            case .division:
                result = (firstOperand / secondOperand)
            case .multiplication:
                result = (firstOperand * secondOperand)
            default:
                print("An unexpected Error has occurred")
                result = firstOperand
        }
        
        // Ready Calculator for next operation
        firstOperand = result
        secondOperand = 0
        operation = .none
        
        // Update result label
        resultLabel.text = String(format: "%g", result)
        
        // Readies calculator after updating result label
        result = 0.0
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        resultLabel.text = "0"
        operation = .none
        firstOperand = 0
        secondOperand = 0
        result = 0
    }
}

