//
//  ViewController.swift
//  Weather
//
//  Created by Jacek Mleczek on 25/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var temperatureView: UILabel!
    @IBOutlet weak var pressureView: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataProvider = (UIApplication.shared.delegate as! AppDelegate)
            .diProvider.provideWeatherDataProvider()
        
        initView()
        let city = "Chojnice"
        cityButton.titleLabel?.text = city
        
        _ = dataProvider.getWeatherData(forCity: city)
            .subscribe(onSuccess: { (weather: Weather) -> Void in
                if let temperature = weather.temperature {
                    self.temperatureView.text = String(format: "%.1f°C", temperature)
                }
                if let pressure = weather.pressure {
                    self.pressureView.text = String(format: "%d hPa", pressure)
                }
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
        navigationController?.pushViewController(citySearchVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

