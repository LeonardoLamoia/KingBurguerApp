//
//  HomeCoordinator.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 28/10/23.
//

import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?
    
    let navFeedVC = UINavigationController()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        let feedCoordinator = FeedCoordinator(navFeedVC)
        feedCoordinator.start()
        
        homeVC.setViewControllers([navFeedVC], animated: true)
        
        // aqui é onde acontece a trocar de navigation-controller
        window?.rootViewController = homeVC
    }
}
