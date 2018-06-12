//
//  AppDelegate.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/11/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        if let listTVC = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? ListTVC, userActivity.activityType == "com.glintpod.order" {
            listTVC.restoreUserActivity(userActivity: userActivity)
            return true
        } else {
            return false
        }
        
    }

}

