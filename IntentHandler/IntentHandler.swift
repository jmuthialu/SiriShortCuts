//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import Intents

class IntentHandler: INExtension, OrderCoffeeIntentHandling
{
    
    func confirm(intent: OrderCoffeeIntent, completion: @escaping (OrderCoffeeIntentResponse) -> Void) {
        completion(OrderCoffeeIntentResponse(code: .ready, userActivity: nil))
    }
    
    func handle(intent: OrderCoffeeIntent, completion: @escaping (OrderCoffeeIntentResponse) -> Void) {
        let orderModel = OrderHistoryModel()
        if let productName = intent.productName {
            orderModel.addOrder(fromIntent: intent)
            completion(OrderCoffeeIntentResponse.success(productName: productName, waitTime: "10"))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }

}
