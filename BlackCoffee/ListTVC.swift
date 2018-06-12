//
//  ListTVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

class ListTVC: UITableViewController {

    var products = [CoffeeModel]()
    var selectedIndex: Int?
    
    func buildModel() {
        let blackCoffee = CoffeeModel(name: "Black Coffee", price: 2)
        let expresso = CoffeeModel(name: "Expresso", price: 5)
        let blackTea = CoffeeModel(name: "Black Tea", price: 3)
        products.append(blackCoffee)
        products.append(expresso)
        products.append(blackTea)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var productIndex: Int?
        
        if let index = tableView.indexPathForSelectedRow?.row {
            productIndex = index
        } else if let index = selectedIndex {
            productIndex = index
        }
        if segue.identifier == "orderSegue", let destVC = segue.destination as? OrderVC,
            let productIndex = productIndex {
            destVC.productName = products[productIndex].name
            destVC.productPrice = products[productIndex].price
            destVC.productIndex = productIndex
        }
    }
    
    func restoreUserActivity(userActivity: NSUserActivity) {
        if let index = userActivity.userInfo?["index"] as? Int {
            selectedIndex = index
            performSegue(withIdentifier: "orderSegue", sender: self)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        cell.detailTextLabel?.text = String(products[indexPath.row].price)
        return cell
    }

}
