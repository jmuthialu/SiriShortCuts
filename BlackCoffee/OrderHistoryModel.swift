//
//  OrderHistoryModel.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/18/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import Foundation
import Intents

class OrderModel {
    
    var name: String = "Coffee"
    var price: Int = 0
    var quantity: Int = 0
    
    init(name: String, price: Int, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
        
    }
}

private var orderHistory = [OrderModel]()

class OrderHistoryModel {
    
    func modelCount() -> Int {
        return orderHistory.count
    }
    
    func addOrder(order: OrderModel, completion: () -> Void) {
        orderHistory.append(order)
        donateIntent(orderPlaced: order)
        completion()
    }
    
    func addOrder(fromIntent intent: OrderCoffeeIntent) {
        guard let productName = intent.productName else { return }
        guard let index = getFirstIndex(byProductName: productName) else { return }
        guard let order = getOrderBy(index: index) else { return }
        
        orderHistory.append(order)
    }
    
    func getFirstIndex(byProductName productName: String) -> Int? {
        return orderHistory.firstIndex(where: { ($0.name == productName) })
    }
    
    func getOrderBy(index: Int) -> OrderModel? {
        return orderHistory[index]
    }
    
    func donateIntent(orderPlaced: OrderModel?) {
        guard let orderPlaced = orderPlaced else { return }
        let intent = OrderCoffeeIntent()
        intent.productName = orderPlaced.name
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
            if let error = error {
                print("Error donating intent: \(error)")
            } else {
                print("Donated intent for product name: \(orderPlaced.name)")
            }
        }
        
    }
    
//    func generateUserActivity() {
//        let activity = NSUserActivity(activityType: "com.glintpod.order")
//        activity.delegate = self
//        activity.isEligibleForSearch = true
//        activity.isEligibleForPrediction = true
//        activity.isEligibleForHandoff = true
//        activity.title = productName
//        userActivity = activity
//    }
    
}


