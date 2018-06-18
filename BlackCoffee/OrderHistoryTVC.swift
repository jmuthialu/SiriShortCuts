//
//  OrderHistoryTVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

class OrderHistoryTVC: UITableViewController {

    var orderHistory = [OrderModel]()
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            destVC.productName = orderHistory[productIndex].name
            destVC.productPrice = orderHistory[productIndex].price
            destVC.productIndex = productIndex
        }
    }
    
    func restoreUserActivity(userActivity: NSUserActivity) {
        if let index = userActivity.userInfo?["index"] as? Int {
            selectedIndex = index
            performSegue(withIdentifier: "orderSegue", sender: self)
        }
    }

    
    func restoreIntent(intent: OrderCoffeeIntent) {
        if let name = intent.name, let index = orderHistory.firstIndex(where: { ($0.name == name) }) {
            selectedIndex = index
            performSegue(withIdentifier: "orderSegue", sender: self)
        }
    }
    
    @IBAction func unwindToOrderHistory(segue: UIStoryboardSegue) {
        if let source = segue.source as? OrderVC, let productOrdered = source.productOrdered {
            orderHistory.append(productOrdered)
            tableView.reloadData()
        }
    }


    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterCell", for: indexPath)
        cell.textLabel?.text = orderHistory[indexPath.row].name
        cell.detailTextLabel?.text = String(orderHistory[indexPath.row].price)
        return cell
    }

}
