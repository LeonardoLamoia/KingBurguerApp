//
//  SignInViewModel.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 06/10/23.
//

import Foundation
import UIKit


protocol SignInViewModelDelegate {
    func viewModelDidChanged(viewModel: SignInViewModel)
}

class SignInViewModel {
    
    var delegate: SignInViewModelDelegate?
    
    var state: Bool = false {
        didSet {
            delegate?.viewModelDidChanged(viewModel: self)
        }
    }
    
    func send() {
        state = true
    }
}
