//
//  CountryDAO.swift
//  PlayMessi
//
//  Created by Mariano D'Agostino on 10/30/16.
//  Copyright © 2016 Tictapps. All rights reserved.
//

import UIKit
import TTMVC

class CountryDAO: TTGenericDAO {

    func getCountries(handler _handler : ((TTResult<[CountryDTO]>)->Void)! ) {
        self.callCollection(url: "https://babytvportal.movix.com/webapi/country/all", debug: true) { (result: TTResult<[CountryDTO]>) in
            _handler(result)
        }
    }

}
