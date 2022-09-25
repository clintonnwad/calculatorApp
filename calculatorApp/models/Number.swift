//
//  NumberFormatter.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//

import Foundation

class Number {
    
    static func format(number :String) -> String?{
        let doubleNumberDouble:Double? = Double(number)
        
        if(doubleNumberDouble == nil){return nil}
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 15
        
        let number = NSNumber(value: doubleNumberDouble!)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }

    
    
}
