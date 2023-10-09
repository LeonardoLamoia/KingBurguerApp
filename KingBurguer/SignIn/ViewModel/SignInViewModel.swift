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
        
        // código de delay, (esperar 2 segundos) - simulando uma latencia de rede
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state = .error("Usuario não existe")
        }
    }
    
    func goToSignUp() {
        coordinator?.signUp()
    }
}
