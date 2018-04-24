//
//  ViewController.swift
//  Weather
//
//  Created by Jacek Mleczek on 25/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController, CitySearchResult {

    @IBOutlet weak var temperatureView: UILabel!
    @IBOutlet weak var pressureView: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var weatherIconView: UIImageView!
    
    let dataProvider = (UIApplication.shared.delegate as! AppDelegate)
        .diProvider.provideWeatherDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        change(city: "Wrocław")
    }
    
    private func change(city: String) {
        initView()
        cityButton.titleLabel?.text = city
        cityButton.setTitle(city, for: .normal)
        
        _ = dataProvider.getWeatherData(forCity: city)
            .subscribe(onSuccess: { (weather) in
                if let temperature = weather.temperature {
                    self.temperatureView.text = String(format: "%.0f°C", temperature)
                }
                if let pressure = weather.pressure {
                    self.pressureView.text = String(format: "%d hPa", pressure)
                }
                if let cityName = weather.cityName {
                    self.cityButton.titleLabel?.text = cityName
                }
                
                self.weatherIconView.image = #imageLiteral(resourceName: "ic_unknown")
                if let icon = weather.icon {
                    switch (icon) {
                    case .brokenClouds:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_broken_clouds")
                    case .clearSkyDay:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_clear_sky_day")
                    case .clearSkyNight:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_clear_sky_night")
                    case .fewCloudsDay:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_few_clouds_day")
                    case .fewCloudsNight:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_few_clouds_night")
                    case .scatteredClouds:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_scattered_clouds")
                    case .showerRain:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_shower_rain")
                    case .rainDay:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_shower_rain")
                    case .rainNight:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_shower_rain")
                    case .thunderstorm:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_thunderstorm")
                    case .snow:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_snow")
                    case .mist:
                        self.weatherIconView.image = #imageLiteral(resourceName: "ic_mist")
                    }
                }
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {})
    }
    
    private func initView() {
        self.temperatureView.text = "?°C"
        self.pressureView.text = "? hPa"
        self.weatherIconView.image = #imageLiteral(resourceName: "ic_unknown")
    }
    
    @IBAction func onCityNameClicked(_ sender: Any) {
        let cityName = cityButton.titleLabel?.text
        
        let citySearchVC = storyboard?.instantiateViewController(withIdentifier: "CitySearchViewController") as! CitySearchViewController
        citySearchVC.actualCity = cityName!
        citySearchVC.citySearchResult = self
        navigationController?.pushViewController(citySearchVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    func select(city: String?) {
        if let selectedCity = city {
            self.change(city: selectedCity)
        }
    }
}

