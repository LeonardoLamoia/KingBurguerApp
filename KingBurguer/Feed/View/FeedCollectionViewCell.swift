//
//  FeedCollectionViewCell.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 05/11/23.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeedCollectionViewCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    let nameLabel: UILabel = {
       let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .red
        lb.font = .systemFont(ofSize: 12)
        lb.text = "Combo KB Kiss"
        return lb
    }()
    
    let priceLabel: UILabel = {
       let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.backgroundColor = .red
        
        lb.layer.borderWidth = 1
        lb.layer.masksToBounds = true
        lb.layer.borderColor = UIColor.lightText.cgColor
        lb.layer.cornerRadius = 5
        
        lb.text = "R$ 29,90"
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - 80)
        nameLabel.frame = CGRect(x: 0, y: bounds.size.height - 80, width: bounds.size.width, height: 28)
        priceLabel.frame = CGRect(x: 0, y: bounds.size.height - 40, width: bounds.size.width, height: 38)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
