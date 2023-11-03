//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 03/11/23.
//

import UIKit

class FeedViewController: UIViewController {
    
    let test: UIView = {
        let v = UIView(frame: CGRect(x: 20, y: 90, width: 20, height: 20))
        v.backgroundColor = .purple
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(test)
       
    }

}
