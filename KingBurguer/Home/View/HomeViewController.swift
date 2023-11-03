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
        
        
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        let couponVC = UINavigationController(rootViewController: CouponViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        
        feedVC.title = "Inicio"
        couponVC.title = "Cupons"
        profileVC.title = "Perfil"
        
        tabBar.tintColor = .red
        
        feedVC.tabBarItem.image = UIImage(systemName: "house")
        couponVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        
        
        setViewControllers([feedVC, couponVC, profileVC], animated: true)
    }
}
