//
//  HomeViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 28/10/23.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let feedInteractor = FeedInteractor()
        let feedViewModel = FeedViewModel(interactor: feedInteractor)
        
        let feedVC = FeedViewController()
        feedVC.viewModel = feedViewModel
        
        let navFeedVC = UINavigationController(rootViewController: feedVC)
        let couponVC = UINavigationController(rootViewController: CouponViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        
        navFeedVC.title = "Inicio"
        couponVC.title = "Cupons"
        profileVC.title = "Perfil"
        
        tabBar.tintColor = .red
        
        navFeedVC.tabBarItem.image = UIImage(systemName: "house")
        couponVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        
        
        setViewControllers([navFeedVC, couponVC, profileVC], animated: true)
    }
}
