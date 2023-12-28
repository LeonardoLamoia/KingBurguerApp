//
//  ViewControllers.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 26/12/23.
//

import UIKit


extension UIViewController {
    
    func configureKeyboard(handle: KeyboardHandle) {
        NotificationCenter.default.addObserver(handle, selector: #selector(handle.onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(handle, selector: #selector(handle.onKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func configureDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func alert(message: String, onClick: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "KingBurguer", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            onClick?()
        }))
        
        self.present(alert, animated: true)
    }
}
