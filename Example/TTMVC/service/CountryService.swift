//
//  CountryService.swift
//  PlayMessi
//
//  Created by Mariano D'Agostino on 10/30/16.
//  Copyright © 2016 Tictapps. All rights reserved.
//

import UIKit
import TTMVC

class CountryService: TTGenericService {

    func getCountries(success: ((_ result: [CountryDTO])->Void)!, error errorBlock: errorResultBlock) {
        let countryDAO = CountryDAO()
        countryDAO.getCountries { result in
            if let countries = result.result {
                success(countries)
            }
        }
    }
    

}
