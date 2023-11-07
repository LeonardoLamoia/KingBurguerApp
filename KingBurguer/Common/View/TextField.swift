//
//  TextField.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 05/11/23.
//

import UIKit

class TextField: UIView {
    

    lazy var ed: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()

    
    let errorLabel: UILabel = {
       let lb = UILabel()
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var placeholder: String? {
        willSet {
            ed.placeholder = newValue
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        willSet {
            if newValue == .emailAddress {
                ed.autocapitalizationType = .none
            }
            ed.keyboardType = newValue
        }
    }
    
    var delegate: UITextFieldDelegate? {
        willSet {
            ed.delegate = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            ed.returnKeyType = newValue
        }
    }
    
    var text: String {
        get {
            return ed.text!
        }
    }
    
    override var tag: Int {
        willSet {
            super.tag = newValue
            ed.tag = newValue
        }
    }
    
    var failure: ( () -> Bool )?
    
    var error: String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(ed)
        addSubview(errorLabel)
        
        configConstraints()
    }
    
    var heightConstraint: NSLayoutConstraint!
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            ed.leadingAnchor.constraint(equalTo: leadingAnchor),
            ed.trailingAnchor.constraint(equalTo: trailingAnchor),
            ed.heightAnchor.constraint(equalToConstant: 50.0),
            
            
            errorLabel.leadingAnchor.constraint(equalTo: ed.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: ed.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: ed.bottomAnchor)
            
        ])
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
    }
    
    func gainFocus() {
        ed.becomeFirstResponder()
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard let f = failure else { return }
        if let error = error {
            if f() {
                errorLabel.text = error
                heightConstraint.constant = 70
            } else {
                errorLabel.text = ""
                heightConstraint.constant = 50
            }
        }
    }
}
