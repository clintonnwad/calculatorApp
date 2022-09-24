//
//  CustomUIView.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//

import UIKit

@IBDesignable
class CustomUIView: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
        }
    }

}
