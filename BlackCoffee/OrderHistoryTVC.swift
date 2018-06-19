//
//  OrderHistoryTVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

class OrderHistoryTVC: UITableViewController {

    var indexFromUserActivity: Int?
    var viewModel = OrderHistoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func restoreIntent(intent: OrderCoffeeIntent) {
        if let name = intent.productName {
            if let index =  viewModel.getFirstIndex(byProductName: name) {
                indexFromUserActivity = index
                performSegue(withIdentifier: "orderViewSegue", sender: self)
            }
        }
    }
    
    func restoreUserActivity(userActivity: NSUserActivity) {
        if let index = userActivity.userInfo?["index"] as? Int {
            indexFromUserActivity = index
            performSegue(withIdentifier: "orderViewSegue", sender: self)
        }
    }
    
    // MARK: - Segue methods
    
    @IBAction func unwindToOrderHistory(segue: UIStoryboardSegue) {
        if let source = segue.source as? OrderVC, let productOrdered = source.productOrdered {
            viewModel.addOrder(order: productOrdered) {
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var productIndex: Int?
        if let index = tableView.indexPathForSelectedRow?.row {
            productIndex = index
        } else if let index = indexFromUserActivity {
            productIndex = index
        }
        if segue.identifier == "orderViewSegue", let destVC = segue.destination as? OrderVC,
            let productIndex = productIndex {
            destVC.productOrdered = viewModel.getOrderBy(index: productIndex)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterCell", for: indexPath)

        if let productName = viewModel.getOrderBy(index: indexPath.row)?.name {
            cell.textLabel?.text = productName
        }
        
        if let productPrice = viewModel.getOrderBy(index: indexPath.row)?.price {
            cell.detailTextLabel?.text = String(productPrice)
        }
        return cell
    }

}
