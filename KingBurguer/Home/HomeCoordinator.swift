//
//  HomeCoordinator.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 28/10/23.
//

import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        // aqui é onde acontece a trocar de navigation-controller
        window?.rootViewController = homeVC
    }
}
