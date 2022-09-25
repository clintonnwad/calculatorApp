//
//  ViewController.swift
//  calculatorApp
//
//  Created by Cee Jaiy on 2022-09-21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var expressLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func onPress(_ sender: UIButton) {
        print(sender.titleLabel?.text)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Number.format(number: "10000000000.0221321234234234234")
        // Do any additional setup after loading the view.
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

