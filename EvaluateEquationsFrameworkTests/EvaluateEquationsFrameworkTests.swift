//
//  EvaluateEquationsFrameworkTests.swift
//  EvaluateEquationsFrameworkTests
//
//  Created by Xinbo Wu on 11/16/18.
//  Copyright © 2018 Xinbo Wu. All rights reserved.
//

import XCTest
@testable import EvaluateEquationsFramework

class EvaluateEquationsFrameworkTests: XCTestCase {
    
    var evaluationHandler: EvaluateEquations!
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        evaluationHandler = EvaluateEquations()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 1. given
        
        let input = "offset  = 4 + destination +1\nlocation = 1 + origin + offset\norigin = 3 + 5\ndestination = 2"
        
        // 2. when
        
        let (resultCode, variables) = evaluationHandler.evaluateEquations(equationsExpressions: input)
        
        // 3. then
        XCTAssertEqual(resultCode, .success, "Evaluation not success")
        
        for (variable, value) in variables! {
            switch variable {
            case "offset":
                XCTAssertEqual(value, 7, "Wrong value for '\(variable)'")
            case "destination":
                XCTAssertEqual(value, 2, "Wrong value for '\(variable)'")
            case "location":
                XCTAssertEqual(value, 16, "Wrong value for '\(variable)'")
            case "origin":
                XCTAssertEqual(value, 8, "Wrong value for '\(variable)'")
            default:
                break
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
