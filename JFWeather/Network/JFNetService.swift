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
    let openWeatherBaseUrlString = "http://api.openweathermap.org/data/2.5/weather"
    let headers = ["Accept": "application/json"]
    
    var alamofireManager: SessionManager?
    
    public static var shareInstance: JFNetService {
        struct Static {
            static let instance: JFNetService = JFNetService()
        }
        return Static.instance
    }
    
    override init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        let manager = SessionManager(configuration: config)
        self.alamofireManager = manager
    }
    
    


}

extension JFNetService {
    
    func getWeatherInfo() {
        
        let weatherParameters = ["q": "Beijing", "appid": openWeatherAPIKey]
        
        Alamofire.request(openWeatherBaseUrlString, method: .get, parameters: weatherParameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote data:\(response)")
                return
            }
            print(response.result.value ?? "No Value")
        }
    }
}
