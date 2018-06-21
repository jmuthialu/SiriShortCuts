//
//  IntentViewController.swift
//  IntentHandlerUI
//
//  Created by Jay Muthialu on 6/18/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling, INUIHostedViewSiriProviding {
    
    @IBOutlet var confirmationView: ConfirmationView!
    @IBOutlet var finalizeView: FinalizeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {

        for view in view.subviews {
            view.removeFromSuperview()
        }

        if interaction.intentHandlingStatus == .unspecified { // from siri. This is not correct way to handle
            view.addSubview(confirmationView)
            if let intent = interaction.intent as? OrderCoffeeIntent, let productName = intent.productName {
                confirmationView.productName.text = "Qty of \(productName)" // Unspecified
                confirmationView.productImageView.image = UIImage(named: productName)
                if let qtyNSNumber = intent.quantity {
                    let qtyInt = Int(truncating: qtyNSNumber)
                    confirmationView.quantity.text = String(qtyInt)
                }
            }
        } else if interaction.intentHandlingStatus == .ready {
            view.addSubview(confirmationView)
            if let intent = interaction.intent as? OrderCoffeeIntent, let productName = intent.productName {
                confirmationView.productName.text = "Qty of \(productName)"
                confirmationView.productImageView.image = UIImage(named: productName)
                if let qtyNSNumber = intent.quantity {
                    let qtyInt = Int(truncating: qtyNSNumber)
                    confirmationView.quantity.text = String(qtyInt)
                }
            }
        } else if interaction.intentHandlingStatus == .success {
            view.addSubview(finalizeView)
            finalizeView.price.text = "$10"
        }

        completion(true, parameters, self.desiredSize)
    }

    var desiredSize: CGSize {
        return CGSize(width: 320, height: 100)
    }
    
}
