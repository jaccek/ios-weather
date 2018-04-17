//
//  CityDataProvider.swift
//  Weather
//
//  Created by Jacek Mleczek on 16/04/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import Foundation
import RxSwift

protocol CityModel {
    
    func getCitiesNames() -> Maybe<[String]>
    
    func save(cityName: String) -> Completable
}
