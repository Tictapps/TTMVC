//
//  TTSGenericDAO.swift
//  TICTAPPS
//
//  Created by Mariano D'Agostino on 5/13/15.
//  Copyright (c) 2015 TICTAPPS. All rights reserved.
//

import Foundation
import Alamofire

open class TTGenericDAO: NSObject {

    public func callCollection<T: TTGenericDTO>(url: String!,
                               method: HTTPMethod = .get,
                               headers: [String: String]? = nil,
                               parameters: [String: AnyObject]? = nil,
                               debug: Bool = false,
                               completionHandler: @escaping (_ result:TTResult<[T]>) -> Void) -> Void {
        
        var realHeaders = [String:String]()
        if let headers = headers {
            realHeaders.merge(with: headers)
        }
        Alamofire.request(url, method: method, parameters: parameters, headers: realHeaders)
            .responseString(completionHandler: { (result) in
                if debug, let value = result.result.value {
                    print(value)
                }
            })
            .responseJSON { (response) in
                let result = TTResult<[T]>()
                if let value = response.result.value as? [String: AnyObject] {
                    if let statusCode = response.response?.statusCode, statusCode >= 400 {
                        if let item = self.parseItem(value: value, type: TTError.self) {
                            result.error = item
                            completionHandler(result)
                            return
                        }
                    }
                }
                if let value = response.result.value as? [[String: AnyObject]] {
                    let results = self.parseCollection(value: value, type: T.self)
                    result.result = results
                    completionHandler(result)
                    return
                }
                completionHandler(result)
        }
    }

    public func call<T: TTGenericDTO>(url: String!,
                                   method: HTTPMethod = .get,
                                  headers: [String: String]? = nil,
                               parameters: [String: AnyObject]? = nil,
                                    debug: Bool = false,
                        completionHandler: @escaping (_ result:TTResult<T>) -> Void) -> Void {
        var realHeaders = [String:String]()
        if let headers = headers {
            realHeaders.merge(with: headers)
        }
        Alamofire.request(url, method: method, parameters: parameters, headers: realHeaders )
            .responseString(completionHandler: { (result) in
                if debug, let value = result.result.value {
                    print(value)
                }
            })
            .responseJSON { (response) in
                let result = TTResult<T>()
                if let value = response.result.value as? [String: AnyObject] {
                    if let statusCode = response.response?.statusCode, statusCode >= 400 {
                        if let item = self.parseItem(value: value, type: TTError.self) {
                            result.error = item
                            completionHandler(result)
                            return
                        }
                    }else{
                        if let item = self.parseItem(value: value, type: T.self) {
                            result.result = item
                            completionHandler(result)
                            return
                        }
                    }
                }
                completionHandler(result)
        }
    }

    internal func parseItem<T: TTGenericDTO>(value: [String: AnyObject]!, type: T.Type) -> T! {
        let item = T(dictionary: value)
        return item
    }
    
    internal func parseCollection<T: TTGenericDTO>(value: Any, type: T.Type) -> [T] {
        var result = [T]()
        for json in value as! [[String: AnyObject]] {
            let item = self.parseItem(value: json, type: type) as T
            result.append(item)
        }
        return result
    }
    

}

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}

