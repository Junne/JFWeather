//
//  User.swift
//  JFWeather
//
//  Created by baijf on 09/12/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let message: String
    
    init?(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        guard let name = obj?["name"] as? String else {
            return nil
        }
        
        guard let message = obj?["message"] as? String else {
            return nil
        }
        
        self.name = name
        self.message = message
    }
}
