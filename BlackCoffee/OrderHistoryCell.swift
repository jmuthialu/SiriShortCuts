//
//  OrderHistoryCell.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/19/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
