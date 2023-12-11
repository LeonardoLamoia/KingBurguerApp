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
        
//        let feedInteractor = FeedInteractor()
//        let feedViewModel = FeedViewModel(interactor: feedInteractor)
//        
//        let feedVC = FeedViewController()
//        feedVC.viewModel = feedViewModel
        
        
//        let couponVC = UINavigationController(rootViewController: CouponViewController())
//        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        
        
//        couponVC.title = "Cupons"
//        profileVC.title = "Perfil"
        
        tabBar.tintColor = .red
        
        
//        couponVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
//        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        
        
    }
}
