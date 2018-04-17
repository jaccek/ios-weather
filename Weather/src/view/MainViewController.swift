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
                    self.temperatureView.text = String(format: "%.1f°C", temperature)
                }
                if let pressure = weather.pressure {
                    self.pressureView.text = String(format: "%d hPa", pressure)
                }
                if let icon = weather.iconId {
                    // TODO: run in background
                    _ = Single.just(icon)
                        .map { (id) in self.dataProvider.getIconUrl(iconId: id) }
                        .map { (url) in URL(string: url)! }
                        .map { (url) in try! Data(contentsOf: url) }
                        .map { (data) in UIImage(data: data)! }
                        .subscribe(onSuccess: { (image) in
                            self.weatherIconView.image = image
                        }, onError: { (error) in
                            // TODO: handle exception
                            print(error.localizedDescription)
                        })
                    
                }
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {})
    }
    
    private func initView() {
        self.temperatureView.text = "?°C"
        self.pressureView.text = "? hPa"
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
    
    func select(city: String?) {
        if let selectedCity = city {
            self.change(city: selectedCity)
        }
    }
}

