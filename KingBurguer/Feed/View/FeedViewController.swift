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
    
    let sections = ["Mais Vendidos", "Vegano", "Bovino", "Sobremesas"]
    
    private let homeFeedTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tv.backgroundColor = UIColor.systemBackground
        
        return tv
    }()
    
    var viewModel:FeedViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        let headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        headerView.backgroundColor = .orange
        homeFeedTable.tableHeaderView = headerView
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        viewModel?.fetch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    
    private func configureNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.red
        
        navigationItem.title = "Produtos"
        var image = UIImage(named: "icon")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(testDidTap)),
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        ]
    }
    
    @objc func testDidTap(_ sender: UIBarButtonItem) {
        print("clicou")
    }
    
}


extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.text = sections[section].uppercased()
        
        view.addSubview(label)
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        
        //        cell.textLabel?.text = "Opa bebê \(indexPath.section) \(indexPath.row)"
        
        return cell
    }
    
    
}

extension FeedViewController: FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState) {
        switch(state) {
        case .loading:
            print("loading..")
            break
        case .success:
            print("sucesso..")
            break
        case .error(let msg):
            print("error..")
            break
        }
    }
}
