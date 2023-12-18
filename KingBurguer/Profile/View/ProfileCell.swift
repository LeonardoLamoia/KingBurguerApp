//
//  ProfileCell.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 17/12/23.
//

import UIKit


class ProfileCell: UITableViewCell {
    
    static let identifier = "ProfileCell"
    
    var data: (String, String)! {
        willSet {
            leftLabel.text = newValue.0
            rightLabel.text = newValue.1
        }
    }
    
    
    private let leftLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Hi my friends"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let rightLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Oi meus amigos"
        lb.textColor = .systemGray
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addElements() {
        
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
    }
    
    
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 10),
            rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
            
        ])
        
    }
}
