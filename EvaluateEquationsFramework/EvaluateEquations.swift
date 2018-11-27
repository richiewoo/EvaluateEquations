//
//  EvaluateEquations.swift
//  EvaluateEquations
//
//  Created by Xinbo Wu on 11/16/18.
//  Copyright © 2018 Xinbo Wu. All rights reserved.
//

public enum EvalutationResultCode: Int {
    case success
    case invalidVariable
    case invalidExpression
    case emptyFile
}

open class EvaluateEquations {
    
    public init() {}
    
    public func evaluateEquations(equationsExpressions: String?) -> (EvalutationResultCode, [(String, Int)]?) {
        
        let (resultCode, equations) = breakDownEquations(equationsExpressions: equationsExpressions)
        
        guard resultCode == .success, let addtionEquations = equations else {
            return (resultCode, nil)
        }
        
        /* Create Arithmetic expression
         * For example: below we have equations:
         
         offset  = 4 + destination +1
         location = 1 + origin + offset
         origin = 3 + 5
         destination = 2
         
         * So we get the ArithmeticExpression below:
         
         ArithmeticExpression.string("offset", ArithmeticExpression.addition([ArithmeticExpression.number(4), ArithmeticExpression.string("destination", nil), ArithmeticExpression.number(1)]))
         ArithmeticExpression.string("location", ArithmeticExpression.addition([ArithmeticExpression.number(1), ArithmeticExpression.string("origin", nil), ArithmeticExpression.string("offset", nil)]))
         ArithmeticExpression.string("origin", ArithmeticExpression.addition([ArithmeticExpression.number(3), ArithmeticExpression.number(5)]))
         ArithmeticExpression.string("destination", ArithmeticExpression.number(2))
         */
        var arithMeticExpressions = [String : ArithmeticExpression]()
        for (variable, operands) in addtionEquations {
            
            //variable and its integer value
            if operands.count == 1 {
                guard let operand = ArithmeticExpression(name: operands.first!.trimmingWhitespaces()) else {
                    return (.invalidExpression, nil)
                }
                
                guard let arithMeticExpression = ArithmeticExpression(name: variable, expression: operand) else {
                    return (.invalidExpression, nil)
                }
                arithMeticExpressions[variable] = arithMeticExpression
            }
            else {
                //Addition expression
                var additionOperands = [ArithmeticExpression]()
                for operand in operands{
                    guard let additionOperand = ArithmeticExpression(name: operand.trimmingWhitespaces()) else {
                        return (.invalidExpression, nil)
                    }
                    additionOperands.append(additionOperand)
                }
                
                guard let arithMeticExpression = ArithmeticExpression(name: variable, expression: ArithmeticExpression(expressions: additionOperands)) else {
                    return (.invalidExpression, nil)
                }
                arithMeticExpressions[variable] = arithMeticExpression
            }
        }
        
        //evaluate equations
        var variables = [(String, Int)]()
        for (variable, expression) in arithMeticExpressions {
            let value = ArithmeticExpression.evaluate(expression, within: Array(arithMeticExpressions.values))
            variables.append((variable, value))
        }
        
        //sort by in ascending order by variable name and return result
        return (.success, variables.sorted(by: { let (firstVariableName, _) = $0, (secondVariableName, _) = $1
            return firstVariableName.localizedCaseInsensitiveCompare(secondVariableName) == .orderedAscending
        }))
    }
    
    /// Break down the equations into left hand side variable and right hand operands
    fileprivate func breakDownEquations(equationsExpressions: String?) -> (EvalutationResultCode, [String : Array<String>]?){
    
        guard let inputEquations = equationsExpressions, !inputEquations.isEmpty else { return (.emptyFile, nil) }
        
        //Get equation from each line
        let equations = inputEquations.components(separatedBy: "\n")
        
        var breakDownEquations = [String : Array<String>]()
        for equation in equations {
            
            //Remove multiple new lines
            guard !equation.isEmpty, !equation.trimmingWhitespaces().isEmpty else {
                continue
            }
            
            // Get variable name
            let variable = equation.components(separatedBy: "=")
            guard let variableName = variable.first?.trimmingWhitespaces(), variableName.isLetterOrDigit() else {
                return (.invalidVariable, nil)
            }
            
            // Get the addtion expression
            let expression = variable.last?.trimmingWhitespaces()
            let operands = expression?.components(separatedBy: "+")
            
            guard (operands?.count)! > 0, operands?.first != nil else {
                return (.invalidExpression, nil)
            }
            
            breakDownEquations[variableName] = operands
        }
        
        return (.success, breakDownEquations)
    }

}
