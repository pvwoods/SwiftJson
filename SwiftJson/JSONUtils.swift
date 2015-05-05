//
//  JSONUtils.swift
//  SwiftJson
//
//  Created by RORY KELLY on 05/05/2015.
//  Copyright (c) 2015 pvwoods. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONUtils {
    /**
    Validate a json string.
    :param: validate a string.
    :returns: Boolean.
    */
    static func validateJSON(jsonText:String)-> Bool {
        if let jsonData = stringToNSData(jsonText) {
            var jsonError: NSError?
            NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError)
            if let unwrappedError = jsonError {
                println("json error: \(unwrappedError)")
                return false
            }
            return true
        }
        return false
    }
    
    /**
    convert a string to NSData.
    :param: validate a string.
    :returns: NSData.
    */
    static func stringToNSData(jsonText:String)-> NSData? {
        if let jsonData = (jsonText as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
            return jsonData
        }
        return .None
    }
    
    /**
    convert a string to a JSON object.
    :param: validate a string.
    :returns: SwiftyJSON.
    */
    static func stringToJSON(jsonText:String)-> JSON? {
        if let jsonData = (jsonText as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
            return JSON(data:jsonData)
        }
        return .None
    }
}