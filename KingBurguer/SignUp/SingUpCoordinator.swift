//
//  SingUpCoordinator.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 07/10/23.
//

import Foundation
import UIKit


class SignUpCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignUpViewModel()
        viewModel.coordinator = self
        
        let signUpVC = SignUpViewController()
        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
}
