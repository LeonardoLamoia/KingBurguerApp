//
//  SignInViewModel.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 06/10/23.
//

import Foundation
import UIKit


protocol SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState)
}

class SignUpViewModel {
    
    var name = "UserA"
    var email = "userA@gmail.com"
    var password = "12345678"
    var document = "111.222.333-11"
    var birthday = "2019-08-24"
    
    var delegate: SignUpViewModelDelegate?
    var coordinator: SignUpCoordinator?
    
    // Notificou  para quem estava observando ele, que o estado mudou
    var state: SignUpState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    // Informa: mudou o estado
    func send() {
        state = .loading
        WebServiceAPI.shared.creatUser(name: name, email: email, password: password, document: document, birthday: birthday)
    }
    
    func goToHome() {
        coordinator?.home()
    }
    
}
