//
//  JFNetService.swift
//  JFWeather
//
//  Created by baijf on 08/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit
import Alamofire

//let openWeatherAPIKey = "80d0f95a328777c02bcd358c813795e1"
let openWeatherAPIKey = "b3e0155a067f8cdc5a2990e9aa83a222"


protocol JSONDecodable {
    static func parse(data: Data) -> Self?
}

protocol JFClient {
    var host: String { get }
    func send<T: JFRequest>(_ r: T, handler: @escaping(T.Response?) -> Void)
}

protocol JFRequest {
    var name: WeatherAPI { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: [String: Any] { get }
    associatedtype Response: JSONDecodable
}



class JFNetService: NSObject {
    
//    let openWeatherBaseUrlString = "http://api.openweathermap.org/data/2.5/weather"
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

extension JFNetService: JFClient {
    internal var host: String {
        return "http://api.openweathermap.org"
    }

    public func send<T : JFRequest>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = host.appending(r.path)
        
        Alamofire.request(url, method: r.method, parameters: r.parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote data:\(response)")
                return
            }
            
            print(response.result.value ?? "No Value")
            
            handler(nil)
            
        }
        
    }

    
//    func getWeatherInfo() {
//        
//        let weatherParameters = ["q": "Beijing", "appid": openWeatherAPIKey]
//        
//        Alamofire.request(openWeatherBaseUrlString, method: .get, parameters: weatherParameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
//            
//            guard response.result.isSuccess else {
//                print("Error while fetching remote data:\(response)")
//                return
//            }
//            print(response.result.value ?? "No Value")
//        }
//    }
}
