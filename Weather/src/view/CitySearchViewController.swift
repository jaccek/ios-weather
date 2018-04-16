//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Jacek Mleczek on 09/04/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit

protocol CitySearchResult {
    func select(city: String?)
}

class CitySearchViewController: UITableViewController {
    
    let dataProvider = (UIApplication.shared.delegate as! AppDelegate)
        .diProvider.provideCityDataProvider()
    
    var actualCity = ""
    var citySearchResult: CitySearchResult?
    var rememeredCities: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        searchBar.text = actualCity
        
        _ = dataProvider.getCitiesNames()
            .subscribe(onSuccess: { (cities) in
                self.rememeredCities = cities
                self.tableView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {})
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rememeredCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCityCell", for: indexPath)
        cell.textLabel?.text = rememeredCities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        citySearchResult?.select(city: cell?.textLabel?.text)
        self.navigationController?.popViewController(animated: true)
    }
}
