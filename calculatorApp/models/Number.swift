//
//  NumberFormatter.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//

import Foundation

class Number {
    
    static var separtor:String = ","
    
    //format number string
    static func format(number :String) -> String?{
        let doubleNumberDouble:Double? = Double(clean(number)!)
        
        if(doubleNumberDouble == nil){return nil}
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 15
        
        let number = NSNumber(value: doubleNumberDouble!)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
    
    //sanitize string remove all separtor
    static func clean(_ number:String)->String? {
        return number.replacingOccurrences(of: separtor, with: "")
    }

    
    
}
