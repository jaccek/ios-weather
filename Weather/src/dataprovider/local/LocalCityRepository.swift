//
//  LocalCityDataProvider.swift
//  Weather
//
//  Created by Jacek Mleczek on 16/04/2018.
//  Copyright © 2018 Jacek Mleczek. All rights reserved.
//

import Foundation
import RxSwift

class LocalCityRepository: CityModel {
    
    // TODO: make it persistance
    var memoryCache = ["Chojnice", "Świdnica", "Wrocław", "Gdańsk", "New York"]
    
    func getCitiesNames() -> Maybe<[String]> {
        return Maybe.just(memoryCache)
    }
    
    func save(cityName: String) -> Completable {
        if (!memoryCache.contains(cityName)) {
            memoryCache.append(cityName)
        }
        return Completable.empty()
    }
}
