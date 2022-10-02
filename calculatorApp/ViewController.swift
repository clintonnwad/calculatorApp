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

class ViewController: UIViewController {
    

    @IBOutlet weak var expressLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    //flag to keep track of state of number
    var isNumberPostive = true
    var userAddedInput = false
    var justEvaluated = false
    
    var inputs:[String] = []
    let operators: [String] = [Strings.divide, Strings.muliply, Strings.plus, Strings.minus]

    
    @IBAction func onPress(_ sender: UIButton) {
        
        if(justEvaluated){
            updateResults("")
            inputs.removeAll()
            displayExpression()
            justEvaluated = false
        }
        
        let char = sender.titleLabel!.text
        var newResults = "\(resultLabel!.text!)\(sender.titleLabel!.text!)"
        let result =  Number.clean(resultLabel!.text!)!

  
            
        //handle backspace
        if(char == Strings.backspace){
            updateResults(String(result.prefix(result.count-1)))
        }
        else if(char == Strings.percentage){
            var value = Float(result)
            if(value != nil) {
                updateResults("\(value!/100)")
            }
        }
        //handle operators
        else if(char == Strings.plus
                || char == Strings.minus
                || char == Strings.muliply
                || char == Strings.divide
               ){
            updateResults("")
            if(!userAddedInput && !inputs.isEmpty && operators.contains(inputs.last!)){
                inputs[inputs.count-1] = char!
            }
            else{
                inputs.append(result)
                inputs.append(char!)
                userAddedInput = false
            }
            displayExpression()
            
        }
        else if(char == Strings.positiveNegative){
            //toggle positive flag varible
            isNumberPostive = !isNumberPostive
            
            //if not positive then append - sign on front and dont format
            if(!isNumberPostive){
                newResults = "-\(resultLabel!.text!)"
                updateResults(newResults,shouldFormat: false)
            }
            else{
                //if positive try remove "-" from current result and update label
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
            if(inputs.count > 0){
                inputs.append(result)
                displayExpression()
                updateResults(removeTrailingDecimals(evalExpression(arr: inputs)!))
                justEvaluated = true
            }
        }
        else if(char == Strings.clear){
            updateResults("")
            inputs.removeAll()
            displayExpression()
        }
        else if(resultLabel.text != nil){
            userAddedInput = true
            updateResults(newResults)
        }
    }
    
    private func removeTrailingDecimals(_ resultDisplay:String)->String{
        var splits = resultDisplay.split(separator: ".")
        if(splits.count > 1){
            if let rightValue = Float(splits[1]){
                if(rightValue == 0){
                    return String(splits[0])
                }
            }
        }
        return resultDisplay
    }
    
    private func displayExpression(){
        
        expressLabel.text = inputs.joined(separator: " ")
        
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
    
    private func _eval(_ left: Float, _ operatar: String, _ right: Float) -> Float? {
      var result: Float? = nil
        if operatar == Strings.plus {
        result = left + right
        } else if operatar == Strings.minus {
        result = left - right
        } else if operatar == Strings.muliply {
        result = left * right
        } else if operatar == Strings.divide {
        result = left / right
      }
      return result
    }

    func evalExpression(arr: [String]) -> String? {

      var array = arr

      //bodmas

      var shouldExit = false

      while !shouldExit {

        var index = 0
        var newArray: [String] = []
        for operatar in operators {
          var didEvalated = false

          for y in 0...array.count - 1 {

            if array[y] == operatar {

              let left: Float = Float(array[y - 1])!
              let right: Float = Float(array[y + 1])!

              let result: Float? = _eval(left, operatar, right)

              let leftIndex = y - 1
              let rightIndex = y + 1

              for r in 0...array.count - 1 {

                if r == y {
                  newArray.append("\(result!)")
                } else if r != leftIndex && r != rightIndex {
                  newArray.append(array[r])
                }
              }

              didEvalated = true
              break
            }

          }
          //exit second loop
          if didEvalated {
            array = newArray
            break
          }

          index = index + 1
        }

        if array.count == 1 {
          shouldExit = true
          return array[0]
        }
      }
    }

    
    
    //force status bar color change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

