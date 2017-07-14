//
//  AppDelegate.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/4.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import UIKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        if AccessToken.current != nil {
            let mainVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "MainVC")
            
            self.window?.rootViewController = mainVC
        }
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var result = true
        
        if (url.absoluteString.range(of: "facebook") != nil){
            result = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }
        
        return result
    }
}

