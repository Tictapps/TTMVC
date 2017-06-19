//
//  TTGenericDTO.swift
//  Encuestas
//
//  Created by Mariano D'Agostino on 5/27/15.
//  Copyright (c) 2015 WOP. All rights reserved.
//

import UIKit

extension NSObject{
    //returns the property type
    func getTypeOfProperty(name:String)->String? {
        let type: Mirror = Mirror(reflecting:self)
        for child in type.children {
            if child.label! == name
            {
                return String(describing: type(of: child.value))
            }
        }
        return nil
    }

    func getTypeOf(name:String)->Any.Type? {
        let type: Mirror = Mirror(reflecting:self)
        for child in type.children {
            if child.label! == name
            {
                return type(of: child.value)
            }
        }
        return nil
    }

}

open class TTGenericDTO: NSObject {

    open func loadFromDictionary(_ dictionary: [String: AnyObject]){
        let propertyNames = self.propertyNames()
        for key in dictionary.keys {
            if propertyNames.contains(key) {
                if let theValue = dictionary[key] {
                    if !(theValue is NSNull) {
                        self.setValue(theValue, forKey: key)
                    }
                }
            }
        }
    }

    func propertyNames() -> [String] {
        let mirrored_object = Mirror(reflecting: self)
        var result = [String]()
        for (_, attr) in mirrored_object.children.enumerated() {
            if let propertyName = attr.label as String! {
                result.append(propertyName)
            }
        }

        // This is an issue as it limits to one subclass 'deep'
        if let parent = mirrored_object.superclassMirror{
            for (_, attr) in parent.children.enumerated() {
                if let propertyName = attr.label as String!{
                    if !result.contains(propertyName) {
                        result.append(propertyName)
                    }
                }
            }
        }
        return result
    }

    override required public init() {
        super.init()
    }

    required public init?(dictionary: [String:AnyObject]) {
        super.init()
        self.loadFromDictionary(dictionary)
    }

}
