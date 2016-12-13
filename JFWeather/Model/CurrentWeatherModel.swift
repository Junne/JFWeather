//
//  CurrertWeatherModel.swift
//  JFWeather
//
//  Created by baijf on 12/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import Foundation
import ObjectMapper

struct CurrentWeatherModel: Mappable {
    
    var code: Int?
    var message: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        code    <- map["cod"]
        message <- map["message"]
    }
}
