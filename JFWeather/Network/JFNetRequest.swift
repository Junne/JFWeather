//
//  JFNetRequest.swift
//  JFWeather
//
//  Created by baijf on 09/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case GET
    case POST
}

protocol JFNetRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    associatedtype Response: Decodable
}

protocol Client {
    var host: String { get }
    func send<T: JFNetRequest>(_ r: T, handler: @escaping(T.Response?) -> Void)
}

protocol Decodable {
    static func parse(data: Data) -> Self?
}

struct UserRequest: JFNetRequest {
    
    let name: String
    var path: String {
        return "/users/\(name)"
    }
    let method:HTTPMethod = .GET
    let parameters: [String: Any] = [:]
    typealias Response = User
}

extension User: Decodable {
    static func parse(data: Data) -> User? {
        return User(data: data)
    }
}

struct URLSessionClient: Client {
    let host = "https://api.onevcat.com"
    
    func send<T : JFNetRequest>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) {
            data, _, error in
            print(data ?? "hello")
            if let data = data, let res = T.Response.parse(data: data) {
                DispatchQueue.main.async {
                    handler(res)
                } } else {
                DispatchQueue.main.async {
                    handler(nil)
                }
            }
        }
        task.resume()
    }
}




















//extension JFNetRequest {
//    func send(handler: @escaping(Response?) -> Void) {
//        let url = URL(string: host.appending(path))!
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        
//        let task = URLSession.shared.dataTask(with: request) {
//            data, _, error in
//            print(data ?? "hello")
//            if let data = data, let res = self.parse(data: data) {
//                DispatchQueue.main.async {
//                    handler(res)
//                } } else {
//                    DispatchQueue.main.async {
//                        handler(nil)
//                    }
//                }
//        }
//        task.resume()
//            }
//}
