//
//  JSONUtilsTests.swift
//  SwiftJson
//
//  Created by RORY KELLY on 05/05/2015.
//  Copyright (c) 2015 pvwoods. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON

class JSONUtilsTests: XCTestCase {
    static let simpleJSON = "{ \"title\": \"Example Schema\", \"type\": \"object\", \"properties\": { \"firstName\": { \"type\": \"string\" }, \"lastName\": { \"type\": \"string\" }, \"age\": { \"description\": \"Age in years\", \"type\": \"integer\", \"minimum\": 0 } }, \"required\": [\"firstName\", \"lastName\"] }"
   
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
        
    func testSringToData() {
        XCTAssertNotNil(JSONUtils.stringToNSData(JSONUtilsTests.simpleJSON), "Pass")
    }
    
    func testValidator() {
        // This is an example of a functional test case.
        XCTAssert(JSONUtils.validateJSON(JSONUtilsTests.simpleJSON), "Pass")
    }
    
    func testGetAllDictionaries() {
        var json:JSON? = JSONUtils.stringToJSON(JSONUtilsTests.simpleJSON)
        var count = 0
        Generator.getAllDictionaries(json!) { (string, [String : JSON]) -> () in
            ++count
        }
        XCTAssertEqual(count, 4, "PASS")
    }
}