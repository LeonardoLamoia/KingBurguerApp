//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 07/10/23.
//

import Foundation
import UIKit


enum SignUpForm: Int {
    case name = 0x1
    case email = 0x2
    case password = 0x4
    case document = 0x8
    case birthday = 0x10
}


class SignUpViewController: UIViewController {
    
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
    
    lazy var textField: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 29)
        return text
    }()
    
    lazy var name: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu nome"
        ed.tag = 1
        ed.bitmask = SignUpForm.name.rawValue
        ed.returnKeyType = .next
        ed.delegate = self
        ed.error = "Nome deve ter no minimo 3 caracteres"
        ed.failure = {
            return ed.text.count < 3
        }
        return ed
    }()
    
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.tag = 2
        ed.bitmask = SignUpForm.email.rawValue
        ed.returnKeyType = .next
        ed.keyboardType = .emailAddress
        ed.delegate = self
        ed.error = "E-mail invalido"
        ed.failure = {
            return !ed.text.isEmail()
        }
        return ed
    }()
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.tag = 3
        ed.bitmask = SignUpForm.password.rawValue
        ed.returnKeyType = .next
        ed.secureTextEntry = true
        ed.delegate = self
        ed.error = "Senha deve ter no minimo 8 caracteres"
        ed.failure = {
            return ed.text.count < 8
        }
        return ed
    }()
    
    lazy var document: TextField = {
        let ed = TextField()
        
        ed.placeholder = "Entre com seu CPF"
        ed.tag = 4
        ed.maskField = Mask(mask: "###.###.###-##")
        ed.bitmask = SignUpForm.document.rawValue
        ed.returnKeyType = .next
        ed.keyboardType = .numberPad
        ed.delegate = self
        ed.error = "CPF deve ter no minimo 11 digitos"
        ed.failure = {
            return ed.text.count != 14
        }
        return ed
    }()
    
    lazy var birthday: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua data de nascimento"
        ed.tag = 5
        ed.maskField = Mask(mask: "##/##/####")
        ed.bitmask = SignUpForm.birthday.rawValue
        ed.returnKeyType = .done
        ed.keyboardType = .numberPad
        ed.delegate = self
        ed.error = "Data de nascimento deve ser dd/MM/yyyy"
        ed.failure = {
            let invalidCount = ed.text.count != 10
            
            let dt = DateFormatter()
            dt.locale = Locale(identifier: "en_US_POSIX")
            dt.dateFormat = "dd/MM/yyyy"
            
            // String -> Date
            let date = dt.date(from: ed.text)
            
            let invalidDate = date == nil
            
            return invalidDate || invalidCount
        }
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.enable(false)
        btn.titleColor = .white
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(sedDidTap))
        return btn
    }()
    
    var viewModel:SignUpViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addElements()
        configConstraints()
        
        configureKeyboard(handle: keyboardHandle)
        configureDismissKeyboard()
    }
    
    private func addElements() {
        container.addSubview(name)
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(document)
        container.addSubview(birthday)
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
            
            
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            name.topAnchor.constraint(equalTo: container.topAnchor, constant: 70.0),
            
            
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10.0),
            
            
            password.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
            
            
            document.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            document.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            document.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            
            
            birthday.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            birthday.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            birthday.topAnchor.constraint(equalTo: document.bottomAnchor, constant: 10.0),
            
            
            send.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            send.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0),
            
        ])
        
    }
    
    
    lazy var keyboardHandle = KeyboardHandle{ visible, height in
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
    
    
    @objc func sedDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
}

extension SignUpViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            return false
        }
        
        let nextTag = textField.tag + 1
        let component = container.findViewByTag(tag: nextTag) as? TextField
        
        if (component != nil) {
            component?.gainFocus()
        } else {
            view.endEditing(true)
        }
        return false
    }
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
            
        } else {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        
        // e-mail e password precisam ser validos
        self.send.enable(
            (SignUpForm.name.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.email.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.password.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.document.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.birthday.rawValue & self.bitmaskResult != 0)
        )
        
        if bitmask == SignUpForm.name.rawValue {
            viewModel?.name = text
        }
        else if bitmask == SignUpForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SignUpForm.password.rawValue {
            viewModel?.password = text
        }
        else if bitmask == SignUpForm.document.rawValue {
            viewModel?.document = text
        }
        else if bitmask == SignUpForm.birthday.rawValue {
            viewModel?.birthday = text
        }
    }
}

//TODO: organizar o projeto separando a extension utilitaria

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}


extension SignUpViewController: SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        switch(state) {
        case .none:
            break
        case .loading:
            send.startLoading(true)
            break
        case .goToLogin:
            send.startLoading(false)
            let alert = UIAlertController(title: "Titulo", message: "Usuario Cadastrado com sucesso!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.viewModel?.goToLogin()
            }))
            self.present(alert, animated: true)
            break
        case .error(let msg):
            send.startLoading(false)
            let alert = UIAlertController(title: "Titulo", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            
            break
        }
    }
}
