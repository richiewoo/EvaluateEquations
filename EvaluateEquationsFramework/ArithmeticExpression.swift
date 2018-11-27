//
//  ArithmeticExpression.swift
//  EvaluateEquations
//
//  Created by Xinbo Wu on 11/16/18.
//  Copyright © 2018 Xinbo Wu. All rights reserved.
//

// MARK: -

/// Recursive enumerations, responseble for creating arithmetic expression from equations, and evaluate equations.
///
/// Three type of expression depends on operands of equation
/// "offset  = 4 + destination +1" as example, we will have below expression:
/// ArithmeticExpression.number(4)
/// ArithmeticExpression.string("destination", nil)
/// ArithmeticExpression.number(1)
public indirect enum ArithmeticExpression{
    case number(Int)
    case string(String, ArithmeticExpression?)
    case addition([ArithmeticExpression])
}

// MARK: - Initialization
extension ArithmeticExpression {
    
   public init?(name: String, expression: ArithmeticExpression?) {
        guard !name.isEmpty else { return nil }
        
        self = .string(name, expression)
    }
    
   public init?(name: String) {
        guard !name.isEmpty else { return nil }
        
        if let integer = Int(name) {
            self = .number(integer)
        } else {
            self = ArithmeticExpression(name: name, expression: nil)!
        }
    }
    
    public init(expressions: [ArithmeticExpression]) {
        self = .addition(expressions)
    }
}

// MARK: - Evaluation
/// A recursive function.
///It evaluates a plain number by simply returning the associated value.
///It evaluates a unknow variable name by looping all equaions by the variable name
///It evaluates an addition by evaluating the expression on the right-hand side, and then adding them”
extension ArithmeticExpression {
    
    static public func evaluate(_ expression: ArithmeticExpression, within expressions: [ArithmeticExpression]) -> Int {
        
        switch expression {
        case .number(let value):
            return value
        case .string(_, let value) where value != nil:
            return evaluate(value!, within: expressions)
        case .string(let name, _):
            for ex in expressions {
                switch ex {
                case let .string(n, value):
                    if name == n {
                        return evaluate(value!, within: expressions)
                    }
                default:
                    break
                }
            }
            return 0
        case .addition(let add):
            var sum = 0
            for ex in add {
                sum += evaluate(ex, within: expressions)
            }
            return sum
        }
    }
}
