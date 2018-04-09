//
//  WeatherDataProvider.swift
//  Weather
//
//  Created by Jacek Mleczek on 18/02/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import UIKit
import RxSwift

protocol WeatherDataProvider {
    
    func getWeatherData(forCity: String) -> Maybe<Weather>
}
