//
//  ProfileCoordinator.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 17/12/23.
//

import Foundation
import UIKit


class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let interactor = FeedInteractor()
        
//        let viewModel = FeedViewModel(interactor: interactor)
//        viewModel.coordinator = self
        
        let vc = ProfileViewController(style: .plain)
//        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
