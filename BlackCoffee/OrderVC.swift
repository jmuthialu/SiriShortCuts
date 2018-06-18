//
//  OrderVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit
import Intents

class OrderVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var productName = ""
    var productPrice: Int = 0
    var productIndex = 0
    var productSelected: ProductModel?
    var productOrdered: OrderModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if let productSelected = productSelected {
            name.text = productSelected.name
            price.text = String(productSelected.price)
        }
    }
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        if let productSelected = productSelected {
            productOrdered = OrderModel(name: productSelected.name, price: productSelected.price, quantity: 1)
            performSegue(withIdentifier: "toOrderHistory", sender: self)
        }
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
    
    func donateIntent() {
        let intent = OrderCoffeeIntent()
        intent.name = productName
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
            if let error = error {
                print("Error donating intent: \(error)")
            }
        }
    }
}

extension OrderVC: NSUserActivityDelegate {
    func userActivityWillSave(_ userActivity: NSUserActivity) {
        userActivity.userInfo = ["index": productIndex]
        print(userActivity.title ?? "")
    }
}
