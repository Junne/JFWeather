//
//  ViewController.swift
//  JFWeather
//
//  Created by baijf on 21/11/2016.
//  Copyright © 2016 Junne. All rights reserved.
//

import UIKit
import RxSwift


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        URLSessionClient().send(UserRequest(name: "onevcat")) { user in
//            
//            print("name = \(user?.name), message = \(user?.message)")
//            
//        }
        
        JFNetService.shareInstance.send(WeatherRequest(name: .currentWeather)) { weather  in
            
            print("code = \(weather?.code), message = \(weather?.message)")
        }
        
        let disposeBag = DisposeBag()
        
        JFNetService.shareInstance.send(WeatherRequest(name: .currentWeather))
            .subscribe({ result in
                print(result)
            }).addDisposableTo(disposeBag)
        

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

