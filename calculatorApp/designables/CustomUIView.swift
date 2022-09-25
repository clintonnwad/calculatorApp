//
//  CustomUIView.swift
//  calculatorApp
//
//  Created by Jovi on 24/09/2022.
//
//  GROUP NUMBER: 15
//  NAMES:
//  Clinton Nwadiukor  - 301291242
//  Jovi Chen-Mcintyre - 301125059

import UIKit

//custom UIView to give IB the ability to set cornerRadius on UIView from the UI
@IBDesignable
class CustomUIView: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
        }
    }

}
