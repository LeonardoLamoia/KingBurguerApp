//
//  ProductDetailViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 13/12/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var id: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        print("estou no ProductDetailViewController: \(id)")
    }
    
}
