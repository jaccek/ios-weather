//
//  NetworkWeatherDataProvider.swift
//  Weather
//
//  Created by Jacek Mleczek on 18/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire

class RemoteWeatherDataProvider: WeatherDataProvider {
    
    private let apiKey: String
    private let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getWeatherData(forCity city: String) -> Maybe<Weather> {
        let url = baseUrl +
            "?q=" + city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! +
            "&units=metric" +
            "&appid=" + apiKey
        
        print(url)
        return RxAlamofire.requestJSON(.get, url)
            .map { (r, json) in json }
            .map { Weather.create(fromJson: $0 as! Dictionary<String, Any?>) }
            .asMaybe()
    }

}