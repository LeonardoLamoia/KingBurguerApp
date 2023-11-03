//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 03/11/23.
//

import UIKit

class FeedViewController: UIViewController {
    
    // 1 . registrar uma calsse que seja UITableViewcell
    // 2 . definir o dataSource (ViewController - que administra fonte de dados)
    // 3 . definir métodos obrigatórios ( numberOfRowsInSection / cellForRowAt )
    
    private let homeFeedTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tv.backgroundColor = UIColor.cyan
        
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}


extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        
        cell.textLabel?.text = "Opa bebê \(indexPath.section) \(indexPath.row)"
        
        return cell
    }
    
    
}
