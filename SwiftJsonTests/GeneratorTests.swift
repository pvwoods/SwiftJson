//
//  GenTests.swift
//  SwiftJson
//
//  Created by RORY KELLY on 04/05/2015.
//  Copyright (c) 2015 pvwoods. All rights reserved.
//

import Foundation

import XCTest
import SwiftyJSON

class GeneratorTests: XCTestCase {
    static let simpleJSON = "{ \"title\": \"Example Schema\", \"type\": \"object\", \"properties\": { \"firstName\": { \"type\": \"string\" }, \"lastName\": { \"type\": \"string\" }, \"age\": { \"description\": \"Age in years\", \"type\": \"integer\", \"minimum\": 0 } }, \"required\": [\"firstName\", \"lastName\"] }"
    var generator:Generator?;
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        generator = Generator(jsonObject: JSONUtils.stringToJSON(GeneratorTests.simpleJSON)!)
    }
    
    override func tearDown() {
        super.tearDown()
        generator = .None
    }
    
    func testGetAllDictionaries() {
        var json:JSON? = JSONUtils.stringToJSON(GeneratorTests.simpleJSON)
        var count = 0
        Generator.getAllDictionaries(json!) { (string, [String : JSON]) -> () in
            ++count
        }
        XCTAssertEqual(count, 4, "PASS")
    }
    
    func testGetAllClassModels(){
        let result = generator!.getAllClassModels()
        // first check that we have the right number of classes
        XCTAssertEqual(result.count, 5, "PASS")
        
        // look at the root class first.
        XCTAssertEqual(result[0].variables.count, 4,"PASS")
        XCTAssertEqual(result[0].variables["title"]!, "String","PASS")
        XCTAssertEqual(result[0].variables["type"]!, "String","PASS")
        XCTAssertEqual(result[0].variables["properties"]!, "properties","PASS")
        XCTAssertEqual(result[0].variables["required"]!, "[String]","PASS")
      
        XCTAssertEqual(result[1].className, "properties", "PASS")
        XCTAssertEqual(result[1].variables["age"]!, "age", "PASS")
        XCTAssertEqual(result[1].variables["firstName"]!, "firstName", "PASS")
        XCTAssertEqual(result[1].variables["lastName"]!, "lastName", "PASS")
        
        XCTAssertEqual(result[2].className, "age", "PASS")
        XCTAssertEqual(result[2].variables["type"]!, "String", "PASS")
        XCTAssertEqual(result[2].variables["minimum"]!, "Double", "PASS")
        XCTAssertEqual(result[2].variables["description"]!, "String", "PASS")
        
        XCTAssertEqual(result[3].className, "firstName", "PASS")
        XCTAssertEqual(result[3].variables["type"]!, "String", "PASS")

        XCTAssertEqual(result[4].className, "lastName", "PASS")
        XCTAssertEqual(result[4].variables["type"]!, "String", "PASS")
        
    }
    
    func testGetClassRepresentation() {
        let classes = generator!.getAllClassModels()
        for classString in classes {
             println(classString)
        }
       
    }
    

}