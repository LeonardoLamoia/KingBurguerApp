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
    let navProfileVC = UINavigationController()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        let feedCoordinator = FeedCoordinator(navFeedVC)
        feedCoordinator.start()
        
        let profileCoordinator = ProfileCoordinator(navProfileVC)
        profileCoordinator.start()
        
        homeVC.setViewControllers([navFeedVC, navProfileVC], animated: true)
        
        window?.rootViewController = homeVC
    }
}
