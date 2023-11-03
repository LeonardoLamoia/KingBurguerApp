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
        let tv = UITableView()
        
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tv.backgroundColor = UIColor.cyan
        
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}


extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = "Opa bebê \(indexPath.row)"
        
        return cell
    }
    
    
}
