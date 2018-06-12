//
//  OrderVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

class OrderVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var productName = ""
    var productPrice: Int = 0
    var productIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        name.text = productName
        price.text = String(productPrice)
        
    }
    
    
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        generateUserActivity()
    }
    
    func generateUserActivity() {
        let activity = NSUserActivity(activityType: "com.glintpod.order")
        activity.delegate = self
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.isEligibleForHandoff = true
        activity.title = productName
        userActivity = activity
    }
}

extension OrderVC: NSUserActivityDelegate {
    func userActivityWillSave(_ userActivity: NSUserActivity) {
        userActivity.userInfo = ["index": productIndex]
        print(userActivity.title ?? "")
    }
}
