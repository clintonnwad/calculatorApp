//
//  NumberFormatter.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//
//  GROUP NUMBER: 15
//  NAMES:
//  Clinton Nwadiukor  - 301291242
//  Jovi Chen-Mcintyre - 301125059
//
//  DESCRIPTION:
//  Simple Calculator app that can perform basic calculator operations
//
//  REVISION HISTORY:
//  https://github.com/clintonnwad/calculatorApp/commits/main
//
//  DATE LAST MODIFIED:
//  September 25, 2022


import Foundation

class Number {
    
    static var separtor:String = ","
    
    //format number string
    static func format(number num :String) -> String?{
        
        var newNumber = num
        var isPositve:Bool = true;
        
        //if str is negative number remove negative sign
        if(newNumber.count >= 1 && newNumber.prefix(1) == Strings.minus){
            isPositve = false
            newNumber.removeFirst()
            newNumber = newNumber.trimmingCharacters(in: .whitespaces)
        }
        
        let doubleNumberDouble:Double? = Double(clean(newNumber)!)
        
        if(doubleNumberDouble == nil){return nil}
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 15
        
        let number = NSNumber(value: doubleNumberDouble!)
        let formattedValue:String = formatter.string(from: number)!
        
        if(isPositve){
            return formattedValue
        }else{
            return "\(Strings.minus) \(formattedValue)"
            
        }
    }
    
    //sanitize string remove all separtor
    static func clean(_ number:String)->String? {
        return number.replacingOccurrences(of: separtor, with: "")
    }

    
    
}
