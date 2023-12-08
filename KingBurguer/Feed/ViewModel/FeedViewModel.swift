//
//  FeedViewModel.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 07/12/23.
//

import Foundation


protocol FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState)
}

class FeedViewModel {
    
    
    var delegate: FeedViewModelDelegate?
//    var coordinator: SignInCoordinator?
    
    
    var state: FeedState = .loading {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: FeedInteractor
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
    }
    // Informa: mudou o estado
    func fetch() {
       interactor.fetch() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else {
                    print(response)
//                    self.state = .goToHome
                }
            }
        }
    }
    
//    func goToSignUp() {
//        coordinator?.signUp()
//    }
//    
//    func goToHome() {
//        coordinator?.home()
//    }
}