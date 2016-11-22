//
//  ViewController.swift
//  JFWeather
//
//  Created by baijf on 21/11/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let openWeatherAPIKey = "83d12c4e4664fbff167c8f114c0679a4"
//    http://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=83d12c4e4664fbff167c8f114c0679a4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=\(openWeatherAPIKey)"
        let parameters : Parameters = ["weather" : "Beijing", "appid" : openWeatherAPIKey];
//        let url = NSURL(fileURLWithPath: urlString)
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather", method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                print(response)
        }
        
        
        
//        Alamofire.request("http://api.openweathermap.org/data/2.5/weather", method: .get , parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders?).validate().responseJSON {
//            
//        }
        
        
//        Alamofire.request(url as! URLRequestConvertible).responseJSON { response in
//            
//            print(response.request ?? "Hello Request")
//            print(response.response ?? "Hello Response")
//            print(response.data ?? "Hello Data")
//            print(response.result)
//            
//            
//        }
        
        
        
//        Alamofire.request(String("http://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=\(openWeatherAPIKey)).responseJSON { response in
//            
//            print(response.request ?? "Hello resquest")
//            
//            
//        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

