//
//  JFRequestRoute.swift
//  JFWeather
//
//  Created by baijf on 08/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


public enum WeatherAPI {
    case currentWeather
}


struct WeatherRequest: JFRequest {
    var name: WeatherAPI 
    
    var path: String {
        switch name {
        case .currentWeather:
            return "/data/2.5/weather?q=Beijing&appid=05cbb7dd309c75745cdd6b4183d7419c"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch name {
        case .currentWeather:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch name {
        case .currentWeather:
            return ["q": "Beijing", "appid": openWeatherAPIKey]
        }
    }
    typealias Response = CurrentWeatherModel
}

extension CurrentWeatherModel: JSONDecodable {
    internal static func parse(json: [String : Any]) -> CurrentWeatherModel? {
        return Mapper<CurrentWeatherModel>().map(JSON: json)
    } 
}
