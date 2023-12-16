//
//  ProductDetailViewController.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 13/12/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var id: Int!
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIStackView = {
        let v = UIStackView(arrangedSubviews: [])
        v.axis = .vertical
        v.distribution = .fill
        v.spacing = 16
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "logo")
        iv.backgroundColor = .red
        return iv
    }()
    
    let containerPrice: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let nameLbl: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = .red
        lb.font = .systemFont(ofSize: 20.0)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Combo XPTO"
        return lb
    }()
    
    let priceLbl: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.backgroundColor = .red
        lb.font = .systemFont(ofSize: 18.0)
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Combo XPTO"
        lb.text = " R$ 29,90 "
        return lb
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Resgatar Cupom", for: .normal)
        btn.layer.borderColor = UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let descLbl: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = .darkText
        lb.numberOfLines = 0
        lb.sizeToFit()
        lb.font = .systemFont(ofSize: 16.0)
        lb.text = """
        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham

        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham

        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham

        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham
       
        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham

        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham
"""
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var viewModel: ProductDetailViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.fetch(id: id)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .systemBackground
        
        addElements()
        
        navigationItem.title = "Cupom"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configConstraints()
        
    }
    
    
    
    private func addElements() {
        
        containerPrice.addSubview(nameLbl)
        containerPrice.addSubview(priceLbl)
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(containerPrice)
        container.addArrangedSubview(descLbl)
        
        scroll.addSubview(container)
        
        view.addSubview(scroll)
        view.addSubview(button)
    }
    
    
    private func configConstraints() {
        
        let sl = scroll.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            container.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.topAnchor.constraint(equalTo: sl.topAnchor),
            container.leadingAnchor.constraint(equalTo: sl.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: sl.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: sl.bottomAnchor),
            
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            nameLbl.leadingAnchor.constraint(equalTo: containerPrice.leadingAnchor, constant: 20),
            nameLbl.topAnchor.constraint(equalTo: containerPrice.topAnchor, constant: 10),
            
            
            priceLbl.trailingAnchor.constraint(equalTo: containerPrice.trailingAnchor, constant: -20),
            priceLbl.topAnchor.constraint(equalTo: containerPrice.topAnchor, constant: 10),
            
            
            containerPrice.heightAnchor.constraint(equalToConstant: 50),
            
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        
    }
    
}

extension ProductDetailViewController: ProductDetailViewModelDelegate {
  
    
    func viewModelDidChanged(state: ProductDetailState) {
        switch(state) {
        case .loading:
            break
        case .success (let response):
            print(response)
//            progress.stopAnimating()
            break
            
            
        case .error(let msg):
//            progress.stopAnimating()
            break
        }
    }
}
