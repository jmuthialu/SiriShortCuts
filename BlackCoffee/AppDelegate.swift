//
//  AppDelegate.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/11/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit
import Intents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        if let orderHistoryTVC = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? OrderHistoryTVC, userActivity.activityType == "com.glintpod.order" {
            
            if let intent = userActivity.interaction?.intent as? OrderCoffeeIntent {
                orderHistoryTVC.restoreIntent(intent: intent)
            }
            return true
        } else {
            return false
        }
        
    }

}

