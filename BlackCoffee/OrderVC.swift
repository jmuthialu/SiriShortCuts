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
    @IBOutlet weak var quantityTextField: UITextField!
    
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
        } else if let productOrdered = productOrdered {
            name.text = productOrdered.name
            price.text = String(productOrdered.price)
            quantityTextField.text = String(productOrdered.quantity)
        }
    }
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        if let productSelected = productSelected {
            productOrdered = OrderModel(name: productSelected.name, price: productSelected.price, quantity: 1)
            performSegue(withIdentifier: "toOrderHistory", sender: self)
        }
    }
    
}

extension OrderVC: NSUserActivityDelegate {
    func userActivityWillSave(_ userActivity: NSUserActivity) {
        userActivity.userInfo = ["index": productIndex]
        print(userActivity.title ?? "")
    }
}
