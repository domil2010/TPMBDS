//
//  ViewController.swift
//  CalculatriceRPN
//
//  Created by Dominique MICHEL on 4/13/18.
//  Copyright © 2018 Dominique MICHEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var calcDisplay: UILabel!
    
    @IBOutlet weak var labelDisplay: UILabel!
    
    @IBOutlet weak var sin: UIButton!
    
    @IBOutlet weak var tan: UIButton!
    
    @IBOutlet weak var second: UIButton!
    
    @IBOutlet weak var cos: UIButton!
    
    var calcEngine: CalculatorEngine?
    
    var butName: String?
    
    var userHasStartedTyping = false;
    
    var labelString: String = ""
    var calcTape = Array<String>()
    @IBAction func digitPressed(_ sender: UIButton) {
        
        let _digit = sender.currentTitle!
        print("digit pressd= \(_digit)")
        
        if userHasStartedTyping{
            labelDisplay.text = labelDisplay.text! + "\(_digit)"
        }else{
            labelDisplay.text = _digit
            userHasStartedTyping = true
        }
    }
    
    @IBOutlet weak var dec: UIButton!
    
    @IBAction func decimal(_ sender: UIButton) {
        
        let decimal = sender.currentTitle!
        
        if userHasStartedTyping{
            labelDisplay.text = labelDisplay.text! + "\(decimal)"
            calcDisplay.text = calcDisplay.text! + "\(decimal)"
            dec.isEnabled = false;
        }else{
            labelDisplay.text=("0")
            userHasStartedTyping = true
            dec.isEnabled = true
        }
    }
    
    
    @IBAction func degRad(_ sender: UIButton) {
        if(sender.titleLabel!.text == "deg"){
            sender.setTitle("rad", for:UIControlState.normal)
            butName = "rad"
        }else{
            sender.setTitle("deg", for: UIControlState.normal)
            butName = "deg"
        }
    }
    
    
    @IBAction func second(_ sender: UIButton) {
        if(sin.titleLabel!.text == "sin"){
            sin.setTitle("sin-¹", for: UIControlState.normal)
        }else{
            sin.setTitle("sin", for: UIControlState.normal)
        }
        if(cos.titleLabel!.text == "cos"){
            cos.setTitle("cos-¹", for: UIControlState.normal)
        }else{
            cos.setTitle("cos", for: UIControlState.normal)
        }
        if(tan.titleLabel!.text == "tan"){
            tan.setTitle("tan-¹", for: UIControlState.normal)
        }else{
            tan.setTitle("tan", for: UIControlState.normal)
        }
        if(second.titleLabel!.text == "2nd"){
            second.setTitle("1st", for: UIControlState.normal)
        }else{
            second.setTitle("2nd", for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        butName = "deg"
        
        if self.calcEngine == nil{
            self.calcEngine = CalculatorEngine()
        }
    }

    var displayValue :Double {
        
        get {
            return(NumberFormatter().number(from: labelDisplay.text!)?.doubleValue)!
        }
        
        set(newValue) {
            labelDisplay.text = "\(newValue)"
        }
    }
    
    @IBAction func enter() {
        userHasStartedTyping = false
        
        self.calcEngine!.operandStack.append(displayValue)
        dec.isEnabled = true
        
        calcDisplay.text! += "\(displayValue)↵"
        
        labelString = labelString + "\(displayValue)↵"
        
        print("Operand Stack on engine = \(self.calcEngine!.operandStack)")
    }
    
    
    @IBAction func operation(_ sender: UIButton) {
        
        let operation = sender.currentTitle!
        if userHasStartedTyping {
            enter()
        }
        self.displayValue = (self.calcEngine?.operate(operation: operation, buttonname: butName!))!
        
        labelString += "\(operation)"
        calcDisplay.text! += "\(operation)"
        enter()
        
        calcTape.append(labelString)
        labelString = ""
    }
    // https://github.com/MBDSTEAMIOS/TP_IOS-Calculatrice.git
    @IBAction func clear(_ sender: UIButton) {
        
        labelDisplay.text = "\(0)"
        
        self.calcEngine!.operandStack.removeLast()
        
        userHasStartedTyping = false
    }
    @IBAction func allClear(_ sender: UIButton) {
        labelDisplay.text = "\(0)"
        calcDisplay.text = "\(0)"
        self.calcEngine!.operandStack.removeAll()
        userHasStartedTyping = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

