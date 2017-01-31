//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Sanni Prasad on 26/01/17.
//  Copyright © 2017 Sanni Prasad. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var outputLbl: UILabel!

    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Addition = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    var currentOperaion = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    
        let soundURL = URL(fileURLWithPath: path!)
        outputLbl.text = "0"
        do{
        
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    @IBAction func numberPressed(sender:UIButton){
       playSound()
        
       runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber

    }
    
    func playSound() {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }

    func processOperation(operation:Operation)  {
        if currentOperaion != Operation.Empty{
            if runningNumber != ""{
                rightValString = runningNumber
                runningNumber = ""
                if currentOperaion == Operation.Multiply{
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                    
                }else if currentOperaion == Operation.Divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"

                }else if currentOperaion == Operation.Addition{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"

                }else if currentOperaion == Operation.Subtract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"

                }
                leftValString = result
                outputLbl.text = result
                
            }
            currentOperaion = operation
        }else{
            leftValString = runningNumber
            runningNumber = ""
            currentOperaion = operation
        }
    }
    
    @IBAction func onDividePressed (sender:AnyObject){
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed (sender:AnyObject){
        processOperation(operation: .Multiply)

    }
    @IBAction func onAddPressed (sender:AnyObject){
        processOperation(operation: .Addition)

    }
    @IBAction func onSubtractPressed (sender:AnyObject){
        processOperation(operation: .Subtract)

    }
    @IBAction func onEqualPressed (sender:AnyObject){
        processOperation(operation: currentOperaion)

    }
    
    @IBAction func ClearBtnPressed(_ sender: UIButton) {
        
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        result = ""
        outputLbl.text = ""
    }
}

