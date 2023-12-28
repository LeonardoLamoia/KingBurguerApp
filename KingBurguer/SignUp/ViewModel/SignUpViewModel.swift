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
    
    var name = ""
    var email = ""
    var password = ""
    var document = ""
    var birthday = ""
    
    var delegate: SignUpViewModelDelegate?
    var coordinator: SignUpCoordinator?
    
    // Notificou  para quem estava observando ele, que o estado mudou
    var state: SignUpState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    // Informa: mudou o estado
    func send() {
        state = .loading
        
        let birthdayFormatted = birthday.toDate()?.toString() ?? ""
        let documentFormatted = document.digits
        
        
        // MAIN-THREAD
        interactor.createUser(request: SignUpRequest(
            name: name,
            email: email,
            password: password,
            document: documentFormatted,
            birthday: birthdayFormatted)) {created, error in
                
                DispatchQueue.main.async {
                    if let errorMessage = error {
                        self.state = .error(errorMessage)
                    } else if let created = created {
                        if created {
                            self.state = .goToLogin
                        }
                    }
                }
            }
    }
    
    func goToLogin() {
        coordinator?.login()
    }
    
}
