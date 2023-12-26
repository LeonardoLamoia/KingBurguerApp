//
//  KeyboardHandle.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 26/12/23.
//

import UIKit


class KeyboardHandle {
    
    let listener: (Bool, CGFloat) -> Void
    
    init(listener: @escaping (Bool, CGFloat) -> Void) {
        self.listener = listener
    }
    
    
    @objc func onKeyboardNotification(_ notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = visible ? UIResponder.keyboardFrameEndUserInfoKey : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            listener(visible, keyboardSize.height)
        }
    }
}
