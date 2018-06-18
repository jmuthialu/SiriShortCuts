//
//  OrderModel.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/17/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import Foundation

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
