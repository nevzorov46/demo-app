//
//  DemoTableViewCell.swift
//  Demo
//
//  Created by Admin on 07.11.2023.
//

import UIKit

class DemoViewCell: UITableViewCell {
    
    static var id = "DemoViewCell"
    
    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainThemeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCell() {
        addSubview(nameLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

extension DemoViewCell: Configurable {
    
    struct Model {
        let name: String
        let price: Int
    }
    
    func configure(with model: Model) {
        self.nameLabel.text = model.name
        self.priceLabel.text = String(model.price)
    }
}
