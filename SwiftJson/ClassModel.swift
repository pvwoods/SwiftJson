//
//  ClassModel.swift
//  SwiftJson
//
//  Created by RORY KELLY on 05/05/2015.
//  Copyright (c) 2015 pvwoods. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
Model to hold definition of classes
*/
struct ClassModel {
    static let CLASS_PLACEHOLDER = "*CLASS*"
    static let VARIABLES_PLACEHOLDER = "*VARIABLES*"
    static let MAPPING_PLACEHOLDER = "*MAPPINGS*"
    static let classStructure =
    "\nclass *CLASS* : Mappable { " +
        "\n     *VARIABLES*" +
        "\n     required init?(_ map: Map){" +
        "\n        mapping(map)" +
        "\n     }\n" +
        "\n     func mapping(map: Map) {" +
        "\n         *MAPPINGS*" +
        "\n     }" +
    " \n}"
    
    let className:String
    let variables:[String:String]
    
    init(name:String, objectDictionary:[String:JSON]){
        className = name;
        variables = ClassModel.getTypes(objectDictionary)
    }
    
    func generateDescription() -> String {
        var variablesString = ""
        var mappingString = ""
        for(name, type) in variables {
            variablesString =  variablesString.stringByAppendingString("var " + name + ":" + type + "? \n      ")
            mappingString = mappingString.stringByAppendingString(name + " <- map[\"" + name + "\"] \n         ")
        }
        return ClassModel.classStructure
            .stringByReplacingOccurrencesOfString(ClassModel.CLASS_PLACEHOLDER, withString: className)
            .stringByReplacingOccurrencesOfString(ClassModel.VARIABLES_PLACEHOLDER, withString: variablesString)
            .stringByReplacingOccurrencesOfString(ClassModel.MAPPING_PLACEHOLDER, withString: mappingString)
    }
    
    /**
    get the types associated with a dictionary.
    :param: dictionary of types in json
    :returns: map [name:type]
    */
    static func getTypes(objectDictionary:[String:JSON]) -> [String:String]{
        var variables:[String:String] = [:]
        // save all of the types
        for(variableName, json) in objectDictionary {
            // variable names are guaranteed to be unique at this point.
            // save a map of object type to name.
            variables[variableName] = ClassModel.getType(variableName, jsonObject: json)
        }
        return variables
    }
    
    /**
    get the type of a single JSON pairing
    :param: key for json object.
    :param: json object to get types for.
    :returns: a string representing the type for a type.
    */
    static func getType(key:String, jsonObject:JSON) -> String {
        switch (jsonObject.type) {
        case .String:
            return "String"
        case .Number:
            return "Double"
        case .Bool:
            return "Bool"
        case .Array:
            return "[" + getType("", jsonObject: jsonObject[0]) + "]"
        case .Dictionary:
            return key
        default:
            return "AnyObject"
        }
    }
}