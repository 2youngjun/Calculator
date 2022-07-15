//
//  ViewController.swift
//  Calculator
//
//  Created by 이영준 on 2022/07/15.
//

import UIKit

enum Calculation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var outputNumber: UILabel!
    
    var firstOperand = ""
    var secondOperand = ""
    
    var displayNumber = ""
    var result = ""
    
    var currentOperation: Calculation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tabNumber(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.outputNumber.text = self.displayNumber
        }
    }
    
    @IBAction func tabDot(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.outputNumber.text = self.displayNumber
        }
    }
    
    @IBAction func tabClear(_ sender: UIButton) {
        self.firstOperand = ""
        self.secondOperand = ""
        self.displayNumber = ""
        self.outputNumber.text = ""
        
        self.currentOperation = .unknown
    }
    
    @IBAction func tabDivide(_ sender: UIButton) {
        self.calculation(.Divide)
    }
    
    @IBAction func tabMultiply(_ sender: UIButton) {
        self.calculation(.Multiply)
    }
    
    @IBAction func tabSubtract(_ sender: UIButton) {
        self.calculation(.Subtract)
    }
    
    @IBAction func tabAdd(_ sender: UIButton) {
        self.calculation(.Add)
    }
    
    
    @IBAction func tabEqual(_ sender: UIButton) {
        self.calculation(self.currentOperation)
    }
    
    func calculation(_ calculation: Calculation){
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result
                self.outputNumber.text = self.result
            }
            self.currentOperation = calculation
            
        } else {
            self.firstOperand = self.displayNumber
            self.displayNumber = ""
            self.currentOperation = calculation
        }
    }
    
}

