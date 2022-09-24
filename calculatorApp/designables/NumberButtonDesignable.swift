//
//  NumberButtonDesignable.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//

import UIKit

@IBDesignable
class NumberButtonDesignable: UIButton {

    @IBInspectable var enableDesign: Bool {
        set {
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            if(newValue){
//                layer.cornerRadius = layer.bounds.height/2
//                titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                layer.masksToBounds = layer.cornerRadius > 0
            }
        }
        get{
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            return self.enableDesign
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
    }
        
    

}
