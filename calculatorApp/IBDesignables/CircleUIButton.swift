//
//  CircleUIButton.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//

import UIKit

@IBDesignable
class OperatorUIButton: UIButton {

    @IBInspectable var enableDesign: Bool = false {
        didSet {
            if(enableDesign){
                layer.cornerRadius = layer.bounds.height/2
//                titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
                layer.masksToBounds = layer.cornerRadius > 0
            }
        }
    }


}
