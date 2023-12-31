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
    
    var sections: [CategoryResponse] = []
    
    private var headerView: HighlightView!
    
    private let progress: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        
        aiv.backgroundColor = .systemBackground
        aiv.startAnimating()
        
        return aiv
    }()
    
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
        
        navigationController?.title = "Inicio"
        navigationController?.tabBarItem.image = UIImage(systemName: "house")
        
        view.addSubview(homeFeedTable)
        view.addSubview(progress)
        
        headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 210))
        headerView.backgroundColor = .orange
        homeFeedTable.tableHeaderView = headerView
        
        headerView.delegate = self
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        viewModel?.fetch()
        viewModel?.fetchHighlight()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        progress.frame = view.bounds
    }
    
    
    private func configureNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.red
        
        navigationItem.title = "Produtos"
        var image = UIImage(named: "icon")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(logoutDidTapped)),
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        ]
    }
    
    @objc func logoutDidTapped() {
        viewModel?.logout()
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
        return 220
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.text = sections[section].name
        
        view.addSubview(label)
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        

        cell.products.append(contentsOf: sections[indexPath.section].products)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension FeedViewController: FeedViewModelDelegate, FeedCollectionViewDelegate, HighlightViewDelegate {
    
    func HighlightSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId)
    }
    
    func itemSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId)
    }
    
    func viewModelDidChanged(state: FeedState) {
        switch(state) {
        case .loading:
            break
        case .success (let response):
            progress.stopAnimating()
            self.sections = response.categories
            self.homeFeedTable.reloadData()
            break
            
        case .successHighlight(let response):
            guard let url = URL(string: response.pictureUrl) else { break }
            headerView.imageView.sd_setImage(with: url)
            headerView.productId = response.productId
            break
            
        case .error(let msg):
            alert(message: msg)
            progress.stopAnimating()
            self.homeFeedTable.reloadData()
            break
        }
    }
}
