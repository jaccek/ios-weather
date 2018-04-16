//
//  DiProvider.swift
//  Weather
//
//  Created by Jacek Mleczek on 18/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit

class DiProvider {
    
    private let openWeatherMapApiKey: String
    
    init() {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            openWeatherMapApiKey = (dict["OpenWeatherMapApi"] as? String)!
        } else {
            openWeatherMapApiKey = ""
        }
    }
    
    func provideWeatherDataProvider() -> WeatherDataProvider {
        // TODO: this should be singleton
        return RemoteWeatherDataProvider(apiKey: openWeatherMapApiKey)
    }
    
    func provideCityDataProvider() -> CityDataProvider {
        // TODO: this should be singleton
        return LocalCityDataProvider()
    }
}
