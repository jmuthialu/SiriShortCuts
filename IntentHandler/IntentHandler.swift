//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

// class IntentHandler: INExtension, INSendMessageIntentHandling, INSearchForMessagesIntentHandling, INSetMessageAttributeIntentHandling {

class IntentHandler: INExtension, OrderCoffeeIntentHandling {
    
    func handle(intent: OrderCoffeeIntent, completion: @escaping (OrderCoffeeIntentResponse) -> Void) {
        return completion(OrderCoffeeIntentResponse(code: .success, userActivity: nil))
    }
    
    func confirm(intent: OrderCoffeeIntent, completion: @escaping (OrderCoffeeIntentResponse) -> Void) {
        
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }

}
