//
//  ViewController.swift
//  JFWeather
//
//  Created by baijf on 21/11/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = UserRequest(name: "onevcat")
        request.send { (user) in
            if let user = user {
                print("\(user.message) from \(user.name)")
            }
        }

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

