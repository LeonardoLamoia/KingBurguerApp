//
//  ProductDetailCoordinator.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 13/12/23.
//

import Foundation
import UIKit

class ProductDetailCoordinator {
    
    private let navigationController: UINavigationController
    private let id: Int
    
    var parentCoordinator: FeedCoordinator?
    
    init(_ navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
//        let interactor = SignUpInteractor()
        
//        let viewModel = SignUpViewModel(interactor: interactor)
//        viewModel.coordinator = self
        
        let vc = ProductDetailViewController()
        vc.id = id
//        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
//    func login() {
//        navigationController.popViewController(animated: true)
//    }
}
