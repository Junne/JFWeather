//
//  JFNetService.swift
//  JFWeather
//
//  Created by baijf on 08/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

let openWeatherAPIKey = "05cbb7dd309c75745cdd6b4183d7419c"
//let openWeatherAPIKey = "b3e0155a067f8cdc5a2990e9aa83a222"


protocol JSONDecodable {
    static func parse(json: [String: Any]) -> Self?
}

protocol JFClient {
    var host: String { get }
    func send<T: JFRequest>(_ r: T, handler: @escaping(T.Response?) -> Void)
    func send<T: JFRequest>(_ r: T) -> Observable<String>
}

protocol JFRequest {
    var name: WeatherAPI { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: [String: Any] { get }
    associatedtype Response: JSONDecodable
}



class JFNetService: NSObject {
    
    internal let headers = ["Accept": "application/json"]
    
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
        
        Alamofire.request(url, method: r.method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            
            switch response.result {
            case .success(let json):
                print(json)
                let weather = T.Response.parse(json: json as! [String : Any])
                handler(weather)
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func send<T : JFRequest>(_ r: T) -> Observable<String> {
        let url = host.appending(r.path)
        
        return Observable.create { [unowned self] observer -> Disposable in
            
            Alamofire.request(url, method: r.method, parameters: r.parameters, encoding: JSONEncoding.default, headers: self.headers).responseJSON { response in
                switch response.result {
                case .success:
                    observer.onNext(String(describing: response.data))
                    observer.onCompleted()
                    
                case .failure(let error):
                    print(String(describing: error))
                    observer.onError(error)
                }
                
            }
            return Disposables.create()
        }
    }
    
}
