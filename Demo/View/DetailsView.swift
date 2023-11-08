//
//  DetailsView.swift
//  Demo
//
//  Created by Admin on 07.11.2023.
//

import UIKit
import Combine

class DetailsView: UIViewController {

    private var anyCancellable = Set<AnyCancellable>()
    var model = PassthroughSubject<ItemResultModel, Never>()

    lazy private var price: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = NSLocalizedString("price", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var keywords: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = NSLocalizedString("keywords", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    private func configureStackView(_ keywords: [String]) {
        for i in 0..<keywords.count {
            let label = UILabel()
            label.font = .systemFont(ofSize: 24)
            label.text = keywords[i]
            stackView.addArrangedSubview(label)
        }
    }

    private func configure() {
        model
            .sink {[weak self] model in
                guard let this = self else { return }
                this.priceLabel.text = String(model.price)
                this.configureStackView(model.keywords)
                this.title = model.name
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        view.backgroundColor = .systemPink
        view.addSubview(keywords)
        view.addSubview(stackView)
        view.addSubview(price)
        view.addSubview(priceLabel)
      
        NSLayoutConstraint.activate([
            keywords.topAnchor.constraint(equalTo: view.centerYAnchor),
            keywords.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            stackView.topAnchor.constraint(equalTo: keywords.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: keywords.centerXAnchor),
            price.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            price.topAnchor.constraint(equalTo: keywords.topAnchor),
            priceLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            priceLabel.centerXAnchor.constraint(equalTo: price.centerXAnchor)
        ])
    }
}
