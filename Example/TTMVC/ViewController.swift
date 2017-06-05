//
//  ViewController.swift
//  TTMVC
//
//  Created by mdagostino on 06/05/2017.
//  Copyright (c) 2017 mdagostino. All rights reserved.
//

import UIKit
import TTMVC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let countryService = CountryService()
        countryService.getCountries(success: { (countries) in
            print(countries)
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

