//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 04/10/23.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
    let email: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .blue
        ed.placeholder = "Entre com seu e-mail"
        return ed
    }()
    
    let password: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .red
        ed.placeholder = "Entre com sua senha"
        return ed
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(email)
        email.frame = CGRect(x: 0, y: view.bounds.size.height / 2, width: view.bounds.size.width, height: 50)
        
        view.addSubview(password)
        password.frame = CGRect(x: 0, y: (view.bounds.size.height) + 50 / 2, width: view.bounds.size.width, height: 50)
    }
}
