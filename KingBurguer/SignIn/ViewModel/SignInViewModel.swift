//
//  SignInViewModel.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 06/10/23.
//

import Foundation
import UIKit


protocol SignInViewModelDelegate {
    func viewModelDidChanged(state: SignInState)
}

class SignInViewModel {
    
    var email = ""
    var password = ""
    
    var delegate: SignInViewModelDelegate?
    var coordinator: SignInCoordinator?
    
    // Notificou  para quem estava observando ele, que o estado mudou
    var state: SignInState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    // Informa: mudou o estado
    func send() {
        state = .loading
        
        WebServiceAPI.shared.login(request: SignInRequest(username: email,
                                                          password: password)) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else {
                    print(response)
                    self.state = .goToHome
                }
            }
        }
    }
    
    func goToSignUp() {
        coordinator?.signUp()
    }
    
    func goToHome() {
        coordinator?.home()
    }
}
