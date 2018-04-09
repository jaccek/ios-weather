//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Jacek Mleczek on 09/04/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit

class CitySearchViewController: UIViewController {
    
    var actualCity = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        searchBar.text = actualCity
    }
}
