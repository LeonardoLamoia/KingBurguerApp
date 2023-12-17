//
//  ProfileViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 03/11/23.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.tabBarItem.image = UIImage(systemName: "person.circle")
        self.tabBarItem?.title = "Perfil"
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Perfil"
        tableView.backgroundColor = .systemGray6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
}
