//
//  WeatherDataProvider.swift
//  Weather
//
//  Created by Jacek Mleczek on 18/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit
import RxSwift

protocol WeatherModel {
    
    func getWeatherData(forCity: String) -> Maybe<Weather>
    
    // TODO: move to separate model
    func getIconUrl(iconId: String) -> String
}
