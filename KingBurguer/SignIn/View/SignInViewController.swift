//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 04/10/23.
//

import Foundation
import UIKit


enum SignInForm: Int {
    case email = 0x1
    case password = 0x2
}

class SignInViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.returnKeyType = .next
        ed.error = "E-mail invalido"
        ed.keyboardType = .emailAddress
        ed.bitmask = SignInForm.email.rawValue
        ed.failure = {
            return !ed.text.isEmail()
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.returnKeyType = .done
        ed.error = "Senha deve ter no minimo 8 caracteres"
        ed.secureTextEntry = true
        ed.bitmask = SignInForm.password.rawValue
        ed.failure = {
            return ed.text.count < 8
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.titleColor = .white
        btn.backgroundColor = .red
        btn.enable(false)
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    lazy var register: UIButton = {
        let btn = UIButton()
        btn.setTitle("Criar Conta", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        //        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside)
        return btn
    }()
    
    var viewModel:SignInViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Login"
        
        setupViews()
        configConstraints()
        
        configureKeyboard(handle: keyboardHandle)
        configureDismissKeyboard()
        
    }
    
    private func setupViews() {
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(send)
        container.addSubview(register)
        container.addSubview(send)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
    }
    
    
    
    private func configConstraints() {
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 490),
            
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            email.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -150),
            
            
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
            
            send.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0),
            
            register.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            register.topAnchor.constraint(equalTo: send.bottomAnchor, constant: 15.0),
            register.heightAnchor.constraint(equalToConstant: 50.0),
            
            
            
        ])
        
    }
    
    lazy var keyboardHandle = KeyboardHandle { visible, height in
        if (!visible) {
            self.scroll.contentInset = .zero
            self.scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
            self.scroll.contentInset = contentInsets
            self.scroll.scrollIndicatorInsets = contentInsets
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // 2. eventos de touch ( Envia para a viewModel uma notificação
    @objc func sendDidTap() {
        viewModel?.send()
    }
    
    @objc func registerDidTap() {
        viewModel?.goToSignUp()
    }
}


extension SignInViewController: TextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
        } else {
            password.gainFocus()
        }
        return false
    }
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
//            print("bitmaskResult is : \(self.bitmaskResult)")
            
        } else {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        
        // e-mail e password precisam ser validos
        self.send.enable((SignInForm.email.rawValue & self.bitmaskResult != 0) && (SignInForm.password.rawValue & self.bitmaskResult != 0))
        
        if bitmask == SignInForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SignInForm.password.rawValue {
            viewModel?.password = text
        }
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
            send.startLoading(true)
            break
        case .goToHome:
            send.startLoading(false)
            // navegar para a tela princiapl
            viewModel?.goToHome()
            break
        case .error(let msg):
            self.send.startLoading(false)
            let alert = UIAlertController(title: "KingBurguer", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            
            break
        }
    }
    
}
