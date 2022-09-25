//
//  ViewController.swift
//  calculatorApp
//
//  Created by Cee Jaiy on 2022-09-21.
//
//  GROUP NUMBER: 15
//  NAMES:
//  Clinton Nwadiukor  - 301291242
//  Jovi Chen-Mcintyre - 301125059

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var expressLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    //flag to keep track of state of number
    var isNumberPostive = true
    
    
    @IBAction func onPress(_ sender: UIButton) {
        let char = sender.titleLabel!.text
        var newResults = "\(resultLabel!.text!)\(sender.titleLabel!.text!)"
        let result =  Number.clean(resultLabel!.text!)!

        //handle backspace
        if(char == Strings.backspace){
            updateResults(String(result.prefix(result.count-1)))
        }
        //handle operators
        else if(char == Strings.plus
                || char == Strings.minus
                || char == Strings.muliply
                || char == Strings.divide
                || char == Strings.percentage){
            updateResults("")
        }
        else if(char == Strings.positiveNegative){
            //toggle positive flag varible
            isNumberPostive = !isNumberPostive
            
            //if not positive then append - sign on front and dont format
            if(!isNumberPostive){
                newResults = "- \(resultLabel!.text!)"
                updateResults(newResults,shouldFormat: false)
            }
            else{
                //if positive try replace - from currenct result and update label
                newResults = resultLabel!.text!.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                updateResults(newResults)
            }
        }
        //if dot append . and dont format
        else if(char == Strings.dot){
            if(!result.contains(".")){
                updateResults(newResults,shouldFormat: false)
            }
        }
        else if(char == Strings.equal){
            updateResults("")
        }
        else if(char == Strings.clear){
            updateResults("")
        }
        else if(resultLabel.text != nil){
            updateResults(newResults)
        }
    }
    
    //update Result label with option to format or not format number
    private func updateResults(_ number:String,shouldFormat:Bool = true) {
        if(number == "" || number == "\(Strings.minus) "){
            resultLabel.text = "0"
            //reset sign
            isNumberPostive = true
        }
        else if(number.contains(".")){
            resultLabel.text = number
        }
        else if(shouldFormat){
            resultLabel.text = Number.format(number: number)
        }
        else{
            resultLabel.text = number

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //force status bar color change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

