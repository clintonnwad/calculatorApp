//
//  CircleUIButton.swift
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


import UIKit
//IB designable add ability to make button prefect circle no matter the height
@IBDesignable
class OperatorUIButton: UIButton {

    @IBInspectable var enableDesign: Bool = false {
        didSet {
            if(enableDesign){
                layer.cornerRadius = layer.bounds.height/2
                layer.masksToBounds = layer.cornerRadius > 0
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if(enableDesign){
            layer.cornerRadius = layer.bounds.height/2
            layer.masksToBounds = layer.cornerRadius > 0
        }
    }


}
