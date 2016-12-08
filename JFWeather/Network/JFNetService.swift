//
//  JFNetService.swift
//  JFWeather
//
//  Created by baijf on 08/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit
import Alamofire

class JFNetService: NSObject {
    
    let openWeatherAPIKey = "83d12c4e4664fbff167c8f114c0679a4"
    let openWeatherUrlString = "http://api.openweathermap.org/data/2.5/weather"
    
    func getWeatherInfo() {
        
        let weatherParameters = ["q": "Beijing", "appid": openWeatherAPIKey]
        
        Alamofire.request(openWeatherUrlString, method: .get, parameters: weatherParameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) -> Void in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote data:\(response)")
                return
            }
            print(response.result.value ?? "No Value")
        }
    }

}
