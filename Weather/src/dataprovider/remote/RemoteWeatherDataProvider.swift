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

class RemoteWeatherDataProvider: WeatherModel {
    
    private let apiKey: String
    private let baseUrl: String = "https://api.openweathermap.org/"
    private let weatherEndpoint: String = "data/2.5/weather"
    private let imageEndpoint: String = "img/w/"
    private let imageExtension: String = ".png"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getWeatherData(forCity city: String) -> Maybe<Weather> {
        let url = baseUrl + weatherEndpoint +
            "?q=" + city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! +
            "&units=metric" +
            "&appid=" + apiKey
        
        print(url)
        return RxAlamofire.requestJSON(.get, url)
            .map { (r, json) in json }
            .map { Weather.create(fromJson: $0 as! Dictionary<String, Any?>) }
            .asMaybe()
    }

    func getIconUrl(iconId: String) -> String {
        return baseUrl + imageEndpoint + iconId + imageExtension
    }
}
