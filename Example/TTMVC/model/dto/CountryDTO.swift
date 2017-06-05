//
//  CountryDTO.swift
//  PlayMessi
//
//  Created by Mariano D'Agostino on 10/30/16.
//  Copyright © 2016 Tictapps. All rights reserved.
//

import UIKit
import TTMVC

class CountryDTO: TTGenericDTO {
    
    var countryID:String?
    var name:String?
    var companies: [CompanyDTO]?
    
    override func loadFromDictionary(_ dictionary: [String : AnyObject]) {
        super.loadFromDictionary(dictionary)
        if let companiesArray = dictionary["companies"] as? [[String: AnyObject]] {
            self.companies = [CompanyDTO]()
            for item in companiesArray {
                if let company = CompanyDTO(dictionary: item) {
                    self.companies?.append(company)
                }
            }
        }
    }
}
