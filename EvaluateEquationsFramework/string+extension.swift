//
//  string+extension.swift
//  EvaluateEquations
//
//  Created by Xinbo Wu on 11/16/18.
//  Copyright © 2018 Xinbo Wu. All rights reserved.
//

import Foundation

extension String {
    
    func isLetterOrDigit() -> Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
//    func removingWhitespaces() -> String {
//        return components(separatedBy: .whitespaces).joined()
//    }
    
    func trimmingWhitespaces() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
