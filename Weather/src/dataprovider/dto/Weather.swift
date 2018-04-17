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
    var iconId: String?
    
    // TODO: visibility, wind, clouds

    static func create(fromJson json: Dictionary<String, Any?>) -> Weather {
        let weather = Weather()
        
        // TODO: handle errors
        let mainData = json["main"] as! Dictionary<String, Any?>
        let weatherData = json["weather"] as! [Any?]
        
        weather.temperature = mainData["temp"] as! Float?
        weather.pressure = (mainData["pressure"] as! NSNumber?)?.intValue
        weather.iconId = (weatherData[0] as! Dictionary<String, Any?>)["icon"] as? String
        
        return weather
    }
}
