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
//  October 02, 2022


import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    

    @IBOutlet weak var expressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //flag to keep track of state of number
    var isNumberPostive = true
    
    //flag trigger when user inputs a number
    var userAddedInput = false
    
    //flag which is set when a evaluation happens
    var justEvaluated = false
    
    //stores expression as array
    var inputs:[String] = []
    
    //operate in order of precedence (BODMAS)
    let operators: [String] = [Strings.divide, Strings.muliply, Strings.plus, Strings.minus]

    
    @IBAction func onPress(_ sender: UIButton) {
        
        
        
        //clear display if user presses any button after just doing an evaluation
        if(justEvaluated){
            updateResults("")
            inputs.removeAll()
            displayExpression()
            justEvaluated = false
        }
        
        
        if(resultLabel.text == nil){
            resultLabel.text = "0"
        }
        
        let char = sender.titleLabel!.text
        var newResults = "\(resultLabel!.text!)\(sender.titleLabel!.text!)"
        let result =  Number.clean(resultLabel!.text!)!
        

        
            
        //handle backspace
        if(char == Strings.backspace){
            updateResults(String(result.prefix(result.count-1)))
        }
        //handle when percent is press
        else if(char == Strings.percentage){
            let value = Float(result)
            if(value != nil) {
                let percentageValue = value!/100
                if(percentageValue != 0){
                    updateResults("\(value!/100)")
                }
            }
        }
        //handle operators
        else if(char == Strings.plus
                || char == Strings.minus
                || char == Strings.muliply
                || char == Strings.divide
               ){
            updateResults("")
            //if last value in input array is an operator and user did not enter an number input then change the operator
            if(!userAddedInput && !inputs.isEmpty && operators.contains(inputs.last!)){
                inputs[inputs.count-1] = char!
            }
            else{
                //if user add an input and operator is pressed then add numnber to array and operator to array
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
            //if array has input try to evaluate them
            if(inputs.count > 0){
                
                //if user entered a number and pressed equal then add number to array and evaluate it
                if(userAddedInput){
                    inputs.append(result)
                    displayExpression()
                    updateResults(removeTrailingDecimals(evalExpression(arr: inputs)!))
                    justEvaluated = true
                }
                //if last value in array is operator and remove that last array value and evaulate the expression
                else if(operators.contains(inputs.last!)){
                    inputs.removeLast()
                    displayExpression()
                    updateResults(removeTrailingDecimals(evalExpression(arr: inputs)!))
                    justEvaluated = true
                }
            }
        }
        else if(char == Strings.clear){
            //remove reset display and inputs
            updateResults("")
            inputs.removeAll()
            displayExpression()
        }
        else if(resultLabel.text != nil){
            // Limit the result to 8 decimal points
            let splits = result.split(separator: ".")
            if(splits.count > 1){
                if(splits[1].count >= 8){
                    return
                }
            }
            
            //if user entered a number trigger flag
            userAddedInput = true
            updateResults(newResults)
        }
    }
    
    //remove decimal if needed
    private func removeTrailingDecimals(_ resultDisplay:String)->String{
        let splits = resultDisplay.split(separator: ".")
        if(splits.count > 1){
            if let rightValue = Float(splits[1]){
                if(rightValue == 0){
                    return String(splits[0])
                }
            }
        }
        return resultDisplay
    }
    
    //display expression in the top of display
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
        else if(shouldFormat && number != Strings.infinity){
            resultLabel.text = Number.format(number: number)
        }
        else{
            resultLabel.text = number

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
    
    //function to do basic maths opteration such as additiaon substraction, mutilpcation and division
    private func _eval(_ left: Float, _ operatar: String, _ right: Float) -> Float? {
      var result: Float? = nil
        if operatar == Strings.plus {
        result = left + right
        } else if operatar == Strings.minus {
        result = left - right
        } else if operatar == Strings.muliply {
        result = left * right
        } else if operatar == Strings.divide {
            // Handle division by zero(0)
            if( right != 0 ){
                result = left / right
            }
      }
      return result
    }

    //function use evaulation maths expression
    func evalExpression(arr: [String]) -> String? {

      var array = arr

    //false to check if while loop should stop
      var shouldExit = false

        //loop that continuiously evalute until the array length is 1
      while !shouldExit {

        var index = 0
        var newArray: [String] = []
        //loop through the operator array in order of precedence
          for operatar in operators {
            //use to tell when an evaultion occured
          var didEvaluated = false

              //looping through the array input and searching for operators
          for index2 in 0...array.count - 1 {
            
              //if operator matches then evaluate the left and right numbers of that index
            if array[index2] == operatar {

                //get left and right number of operator index
              let leftOperand: Float = Float(array[index2 - 1])!
              let rightOperand: Float = Float(array[index2 + 1])!

                //do basic evaluation
              let result: Float? = _eval(leftOperand, operatar, rightOperand)
              if( result == nil ){
                  return Strings.infinity
              }
              let leftOperandIndex = index2 - 1
              let rightOperandIndex = index2 + 1

                //create new array
              for index3 in 0...array.count - 1 {

                  //if index3 is equal to the operator index then append result to new array
                if index3 == index2 {
                  newArray.append("\(result!)")
                }
                //if index3 is not equal to left number index and the right number index then append that value to new array
                  else if index3 != leftOperandIndex && index3 != rightOperandIndex {
                  newArray.append(array[index3])
                }
              }

                //trigger did evaulate flag and break out of loop
                didEvaluated = true
              break
            }

          }
          //check evaluate flag and break out of loop if true
          if didEvaluated {
            array = newArray
            break
          }

          index = index + 1
        }

          //exit while loop when the array length is one meaning it has not more expression to evalate
        if array.count == 1 {
          shouldExit = true
          return array[0]
        }
      }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    //force status bar color change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

