//
//  ProductTVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/17/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

class ProductTVC: UITableViewController {

    var products = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildProductModel()
    }
    
    func buildProductModel() {
        if products.count == 0 {
            let cappuccino = ProductModel(name: "Cappuccino", price: 10)
            let expresso = ProductModel(name: "Espresso", price: 5)
            let blackTea = ProductModel(name: "Tea", price: 5)
            products.append(cappuccino)
            products.append(expresso)
            products.append(blackTea)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderSegue" {
            if let destVC = segue.destination as? OrderVC, let index = tableView.indexPathForSelectedRow?.row {
                destVC.productSelected = products[index]
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        return cell
    }

}
