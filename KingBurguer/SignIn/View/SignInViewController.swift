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
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let password: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .red
        ed.placeholder = "Entre com sua senha"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var send: UIButton = {
        let btn = UIButton()
        btn.setTitle("Entrar", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(sendDidTap), for: .touchUpInside)
        return btn
    }()
    
    var viewModel:SignInViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(send)
        configConstraints()
        
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            email.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            email.heightAnchor.constraint(equalToConstant: 50.00),
            
            
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
            password.heightAnchor.constraint(equalToConstant: 50.0),
            
            send.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
            
        ])
        
        
    }
    // 2. eventos de touch ( Envia para a viewModel uma notificação
    @objc func sendDidTap() {
        viewModel?.send()
    }
}


// 3. Observers
extension SignInViewController: SignInViewModelDelegate {
    // novos dados chegou
    func viewModelDidChanged(state: SignInState) {
        switch(state) {
        case .none:
            break
        case .loading:
            // mostrar a progress
            break
        case .goToHome:
            // navegar para a tela princiapl
            break
        case .error(let msg):
            let alert = UIAlertController(title: "Titulo", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            
            break
        }
    }
    
}
