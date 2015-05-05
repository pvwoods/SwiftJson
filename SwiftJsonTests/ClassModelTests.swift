//
//  ClassModelTests.swift
//  SwiftJson
//
//  Created by RORY KELLY on 05/05/2015.
//  Copyright (c) 2015 pvwoods. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON

class ClassModelTests: XCTestCase {
    static let simpleJSON = "{ \"title\": \"Example Schema\", \"type\": \"object\", \"properties\": { \"firstName\": { \"type\": \"string\" }, \"lastName\": { \"type\": \"string\" }, \"age\": { \"description\": \"Age in years\", \"type\": \"integer\", \"minimum\": 0 } }, \"required\": [\"firstName\", \"lastName\"] }"
    var classModel:ClassModel?
    var json:JSON?;
    
    override func setUp() {
        super.setUp()
        json = JSONUtils.stringToJSON(ClassModelTests.simpleJSON)
        // Put setup code here. This method is called before the invocation of each test method in the class.
        classModel = ClassModel(name: "className", objectDictionary: json!.dictionary!)
    }
    
    override func tearDown() {
        super.tearDown()
        classModel = .None
    }
    
    func testGenerateDescription() {
        classModel!.generateDescription()
    }
    
    func testGetTypes() {
        var nameType = ClassModel.getTypes(json!.dictionary!)
        XCTAssertEqual(nameType.count, 4, "PASS")
        XCTAssertEqual(nameType["title"]!, "String","PASS")
        XCTAssertEqual(nameType["type"]!, "String","PASS")
        XCTAssertEqual(nameType["properties"]!, "properties","PASS")
        XCTAssertEqual(nameType["required"]!, "[String]","PASS")
    }
    
    
    func testGetType()  {
        XCTAssertEqual(ClassModel.getType("title", jsonObject: json!["title"]), "String")
    }
    
}