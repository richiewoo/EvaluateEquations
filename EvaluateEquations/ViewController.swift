//
//  ViewController.swift
//  EvaluateEquations
//
//  Created by Xinbo Wu on 11/16/18.
//  Copyright © 2018 Xinbo Wu. All rights reserved.
//

import UIKit
import EvaluateEquationsFramework

class ViewController: UIViewController {
    
    @IBOutlet weak var equationsView: UITextView!
    @IBOutlet weak var outputView: UITextView!
    
    var equationsExpressions: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        equationsExpressions = try? String(contentsOfFile: Bundle.main.bundlePath + "/equationsFile.txt")
        equationsView.text = "Intput:\n\n" + (equationsExpressions ?? "")
    }
    
    @IBAction func evaluate(_ sender: Any) {
        
        let (resultCode, variables) = EvaluateEquations().evaluateEquations(equationsExpressions: equationsExpressions)
        
        var message: String
        switch resultCode {
        case .success:
            var output: String = ""
            for (variable, value) in variables! {
                output = output + variable + " = \(value)\n"
            }
            outputView.text = "Output:\n\n" + output
            return
        case .invalidVariable:
            message = "Invalid variable"
        case .invalidExpression:
            message = "Invalid expression"
        case .emptyFile:
            message = "Empty file"
        }
        
        let alert = UIAlertController(title: "File error", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

