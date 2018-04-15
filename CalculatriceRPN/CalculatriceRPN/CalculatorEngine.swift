//
//  CalculatorEngine.swift
//  CalculatriceRPN
//
//  Created by Dominique MICHEL on 4/14/18.
//  Copyright © 2018 Dominique MICHEL. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class CalculatorEngine: NSObject{
    
    var operandStack = Array<Double>()
    
    func updateStackWithValue(value: Double){
        self.operandStack.append(value)
    }
    
    func sindegrees(degrees: Double)->Double{
        return sin(degrees * Double.pi / 180.0)
    }
    
    func cosdegrees(degrees: Double)->Double{
        return cos(degrees * Double.pi / 180.0)
    }
    
    func tandegrees(degrees: Double)->Double{
        return tan(degrees * Double.pi / 180.0)
    }
    
    func asinradian(radian: Double)->Double{
        return asin(radian) * (180.0 / Double.pi)
    }
    
    func acosradian(radian: Double)->Double{
        return acos(radian) * (180.0 / Double.pi)
    }
    
    func atanradian(radian: Double)->Double{
        return atan(radian) * (180.0 / Double.pi)
    }
    
    func operate(operation: String, buttonname: String)->Double{
        
        switch operation{
            
        case "×":
            if operandStack.count >= 2 {
                return self.operandStack.removeLast() * self.operandStack.removeLast()
            }
        case "÷":
            if operandStack.count >= 2{
                return self.operandStack.removeFirst() / self.operandStack.removeLast()
            }
        case "−":
            if operandStack.count >= 2 {
                return self.operandStack.removeFirst() - self.operandStack.removeLast()
            }
        case "+":
            if operandStack.count >= 2{
                return self.operandStack.removeLast() + self.operandStack.removeLast()
            }
        case "±":
            return self.operandStack.removeLast()*(-1)
        case "⅟x":
            return 1 / self.operandStack.removeLast()
        case "x²":
            let number = self.operandStack.removeLast()
            return number * number
        
        case "√":
            return sqrt(self.operandStack.removeLast())
        case "𝛑":
            let ans = self.operandStack.removeLast() * Double.pi
            return round(ans * 1000000) / 1000000
        case "logᵉ":
            return log(self.operandStack.removeLast())
            
        case "log₁₀":
            return log10(self.operandStack.removeLast())
            
        case "sin":
            if (buttonname == "rad"){
                return sin(self.operandStack.removeLast())
            }else{
                return sindegrees(degrees: self.operandStack.removeLast())
            }
        case "cos":
            if (buttonname == "rad"){
                return cos(self.operandStack.removeLast())
            }else{
                return cosdegrees(degrees: self.operandStack.removeLast())
            }
        case "tan":
            if (buttonname == "rad"){
                return tan(self.operandStack.removeLast())
            }else{
                return tandegrees(degrees: self.operandStack.removeLast())
            }
        case "sin-¹":
            if (buttonname == "rad"){
                return asin(self.operandStack.removeLast())
            }else{
                return asinradian(radian: self.operandStack.removeLast())
            }
        case "cos-¹":
            if (buttonname == "rad"){
                return acos(self.operandStack.removeLast())
            }else{
                return acosradian(radian: self.operandStack.removeLast())
            }
        case "tan-¹":
            if (buttonname == "rad"){
                return atan(self.operandStack.removeLast())
            }else{
                return atanradian(radian: self.operandStack.removeLast())
            }
        default:
            break
        }
        return 0.0
    }
}
