//
//  PlistManager.swift
//  TestTablePasoPaso
//
//  Created by Mariano D'Agostino on 5/3/17.
//  Copyright © 2017 Digital House. All rights reserved.
//

import Foundation

open class TTPlistManager {
    
    static open func readArray(name: String) -> [[String: AnyObject]] {
        var result: [[String: AnyObject]] = []
        if let plistPath = Bundle.main.path(forResource: name, ofType: "plist"), let plistData = FileManager.default.contents(atPath: plistPath) {
            var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
            do {
                result = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [[String: AnyObject]]
            } catch {
                print("Error reading plist: \(error)")
            }
        }
        return result
    }

    static open func readDictionary(name: String) -> [String: AnyObject] {
        var result: [String: AnyObject] = [:]
        if let plistPath = Bundle.main.path(forResource: name, ofType: "plist"), let plistData = FileManager.default.contents(atPath: plistPath) {
            var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
            do {
                result = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String: AnyObject]
            } catch {
                print("Error reading plist: \(error)")
            }
        }
        return result
    }

    static open func readArrayToObject(name: String, object: TTGenericDTO.Type) -> [TTGenericDTO] {
        let array = readArray(name: name)
        var results: [TTGenericDTO] = []
        for itemDictionary in array {
            if let item = object.init(dictionary: itemDictionary) {
                results.append(item)
            }
        }
        return results
    }
    
    static open func readDictionaryToObject(name: String, object: TTGenericDTO.Type) -> TTGenericDTO {
        let itemDictionary = readDictionary(name: name)
        return object.init(dictionary: itemDictionary)!
    }

}




