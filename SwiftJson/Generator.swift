//
//  Generator.swift
//  SwiftJson
//
//  Created by RORY KELLY on 09/05/2015.
//  Copyright (c) 2015 pvwoods. All rights reserved.
//

import Foundation
import SwiftyJSON

class Generator {
    
    private let rootObject:JSON
    
    init(jsonObject:JSON){
        rootObject = jsonObject
    }
    
    static func getAllDictionaries(object:JSON, function:(String,[String : JSON]) -> ()) {
        for (key: String, subJson: JSON) in object {
            if (subJson.type == .Dictionary) {
                function(key, subJson.dictionaryValue)
                getAllDictionaries(subJson, function: function);
            } else  if (subJson.type == .Array) {
                if(subJson[0].type == .Dictionary){
                    function(key, subJson[0].dictionaryValue)
                    getAllDictionaries(subJson[0], function: function)
                }
            }
        }
    }
    
    func getAllClassModels() -> [ClassModel] {
        var classModels:[ClassModel] = []
        if (rootObject.type == .Dictionary) {
           classModels.append(ClassModel(name: "rootClass", objectDictionary: rootObject.dictionaryValue))
        } else  if (rootObject.type == .Array) {
            if(rootObject[0].type == .Dictionary){
                Generator.getAllDictionaries(rootObject, function: { (name, dictionary) -> () in
                    classModels.append(ClassModel(name: name, objectDictionary: dictionary))
                })
                return classModels
            }
        }
    
        Generator.getAllDictionaries(rootObject, function: { (name, dictionary) -> () in
            classModels.append(ClassModel(name: name, objectDictionary: dictionary))
        })
        return classModels
    }
    
    func getFinalOutput() -> String {
        let classModels = getAllClassModels()
        var finalOutput = ""
        for classModel in  classModels {
            finalOutput = finalOutput.stringByAppendingString(classModel.generateDescription())
        }
        return finalOutput
    }
    
    
    
}