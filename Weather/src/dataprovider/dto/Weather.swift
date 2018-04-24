//
//  Weather.swift
//  Weather
//
//  Created by Jacek Mleczek on 18/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit

class Weather {
    
    var temperature: Float?
    var pressure: Int?
    var icon: IconType?
    var cityName: String?
    
    // TODO: visibility, wind, clouds

    static func create(fromJson json: Dictionary<String, Any?>) -> Weather {
        let weather = Weather()
        
        let mainData = json["main"] as? Dictionary<String, Any?>
        let weatherData = json["weather"] as? [Any?]
        
        weather.temperature = mainData?["temp"] as? Float
        weather.pressure = (mainData?["pressure"] as? NSNumber?)??.intValue
        weather.cityName = json["name"] as? String
        
        let firstData = weatherData?[0] as? Dictionary<String, Any?>
        let iconId = firstData?["icon"] as? String
        switch (iconId)
        {
        case "01d"?:
            weather.icon = .clearSkyDay
        case "01n"?:
            weather.icon = .clearSkyNight
        case "02d"?:
            weather.icon = .fewCloudsDay
        case "02n"?:
            weather.icon = .fewCloudsNight
        case "03d"?:
            weather.icon = .scatteredClouds
        case "03n"?:
            weather.icon = .scatteredClouds
        case "04d"?:
            weather.icon = .brokenClouds
        case "04n"?:
            weather.icon = .brokenClouds
        case "09d"?:
            weather.icon = .showerRain
        case "09n"?:
            weather.icon = .showerRain
        case "10d"?:
            weather.icon = .rainDay
        case "10n"?:
            weather.icon = .rainNight
        case "11d"?:
            weather.icon = .thunderstorm
        case "11n"?:
            weather.icon = .thunderstorm
        case "13d"?:
            weather.icon = .snow
        case "13n"?:
            weather.icon = .snow
        case "50d"?:
            weather.icon = .mist
        case "50n"?:
            weather.icon = .mist
        default:
            weather.icon = nil
        }
        
        return weather
    }
}
