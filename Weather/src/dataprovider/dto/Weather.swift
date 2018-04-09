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

    static func create(fromJson json: Dictionary<String, Any?>) -> Weather {
        let weather = Weather()
        
        // TODO: handle errors
        let mainData = json["main"] as! Dictionary<String, Any?>
        
        weather.temperature = mainData["temp"] as! Float?
        weather.pressure = (mainData["pressure"] as! NSNumber?)?.intValue
        
        return weather
    }
}
