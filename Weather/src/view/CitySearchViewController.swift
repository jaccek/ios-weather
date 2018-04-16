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

class CitySearchViewController: UITableViewController, UISearchBarDelegate {
    
    let dataProvider = (UIApplication.shared.delegate as! AppDelegate)
        .diProvider.provideCityDataProvider()
    
    var actualCity = ""
    var citySearchResult: CitySearchResult?
    var allRememeredCities: [String] = []
    var filteredCities: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        _ = dataProvider.getCitiesNames()
            .subscribe(onSuccess: { (cities) in
                self.allRememeredCities = cities
                self.filteredCities = cities
                self.tableView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {})
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCityCell", for: indexPath)
        cell.textLabel?.text = filteredCities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let cityName = cell?.textLabel?.text
        
        if let name = cityName {
            citySearchResult?.select(city: name)
            _ = dataProvider.save(cityName: name)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCities = filterCities(byName: searchText)
        self.tableView.reloadData()
    }
    
    private func filterCities(byName query: String) -> [String] {
        if (query.isEmpty) {
            return allRememeredCities
        }
        // TODO: ignore polish chars
        var result = allRememeredCities.filter { (city) in city.lowercased().contains(query.lowercased()) }
        if (result.isEmpty) {
            result.append(query)
        }
        return result
    }
}
