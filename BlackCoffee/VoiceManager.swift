//
//  VoiceManager.swift
//  BlackCoffee
//
//  Created by Jay Muthialu on 6/25/18.
//  Copyright © 2018 Jay Muthialu. All rights reserved.
//

import Foundation
import Intents

class VoiceManager {
    
    var voiceShortcuts: [INVoiceShortcut] = []
    
    init() {
        updateVoiceShortcuts(completionBlock: nil)
    }
    
    func getVoiceShortcut(fromOrder: OrderModel) -> INVoiceShortcut? {
        let voiceShortcut = voiceShortcuts.first { (voiceShortcut) -> Bool in
            guard let intentFromShortcut = voiceShortcut.__shortcut.intent as? OrderCoffeeIntent else { return false }
            let intentFromOrder = fromOrder.orderIntent
            if intentFromOrder.productName == intentFromShortcut.productName &&
                intentFromOrder.quantity == intentFromShortcut.quantity {
                return true
            }
            return false 
        }
        if let _ = voiceShortcut {
            return voiceShortcut
        } else {
            return nil
        }
    }
    
    func updateVoiceShortcuts(completionBlock: (() -> Void)?) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (shortcutsFromCenter, error) in
            guard let shortcutsFromCenter = shortcutsFromCenter else { return }
            self.voiceShortcuts = shortcutsFromCenter
            if let completionBlock = completionBlock {
                completionBlock()
            }
            
        }
        
    }
}
