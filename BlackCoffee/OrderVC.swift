//
//  OrderVC.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/12/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

class OrderVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var addToSiri: UIButton!
    
    var productName = ""
    var productPrice: Int = 0
    var productIndex = 0
    var productSelected: ProductModel?
    var productOrdered: OrderModel?
    var voiceManager = VoiceManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if let productSelected = productSelected { // order creation from ProductModel
            name.text = productSelected.name
            price.text = String(productSelected.price)
            addToSiri.isHidden = true
        } else if let productOrdered = productOrdered { // display order from OrderHistoryTVC
            name.text = productOrdered.name
            price.text = String(productOrdered.price)
            quantityTextField.text = String(productOrdered.quantity)
            addToSiri.isHidden = false
        }
        if let invocationPhrase = getInvocationPhrase(fromOrder: productOrdered) {
            addToSiri.setTitle("Say to Siri: " + invocationPhrase, for: UIControl.State.normal)
            print(addToSiri.titleLabel?.text ?? "invocationPhrase")
        }
    }
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        if let productSelected = productSelected {
            productOrdered = OrderModel(name: productSelected.name, price: productSelected.price, quantity: 1)
            performSegue(withIdentifier: "toOrderHistory", sender: self)
        }
    }
    
    @IBAction func addToSiriTapped(_ sender: Any) {
        guard !addToSiri.isHidden else { return }
        guard let orderIntent = productOrdered?.orderIntent else { return }
        guard let shortcut = INShortcut(intent: orderIntent) else { return }
        let addVoiceShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        addVoiceShortcutVC.delegate = self
        present(addVoiceShortcutVC, animated: true, completion: nil)
    }
    
    func updateVoiceShortcuts() {
        voiceManager.updateVoiceShortcuts { [weak self] in
            if let invocationPhrase = self?.getInvocationPhrase(fromOrder: self?.productOrdered) {
                DispatchQueue.main.async {
                    self?.addToSiri.titleLabel?.text = invocationPhrase
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getInvocationPhrase(fromOrder order: OrderModel?) -> String? {
        guard let order = order else { return nil }
        print(voiceManager.voiceShortcuts.count)
        if let shortCut = voiceManager.getVoiceShortcut(fromOrder: order) {
            return shortCut.invocationPhrase
        }
        return nil
    }
    
}

extension OrderVC: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error as NSError? {
            print("error adding voice shortcut: \(error)")
            return
        }
        updateVoiceShortcuts()
    }
}

extension OrderVC: NSUserActivityDelegate {
    func userActivityWillSave(_ userActivity: NSUserActivity) {
        userActivity.userInfo = ["index": productIndex]
        print(userActivity.title ?? "")
    }
}
