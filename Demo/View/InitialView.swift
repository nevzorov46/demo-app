//
//  InitialView.swift
//  Demo
//
//  Created by Admin on 06.11.2023.
//

import UIKit
import Combine

class InitialView: UIViewController {
    
    private let viewModel = ViewModel()
    private var anyCancellable = Set<AnyCancellable>()
    
    lazy private var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DemoViewCell.self, forCellReuseIdentifier: DemoViewCell.id)
        view.isHidden = true
        view.alwaysBounceVertical = false
        return view
    }()
    
    lazy private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        view.color = .mainThemeColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Demo"
        setupNavigationController()
        setupActivityIndicator()
        setupTableView()
        fetchResults()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
    }
    
    private func fetchResults() {
        activityIndicator.startAnimating()
        viewModel.getResults()
        viewModel.$results
            .receive(on: DispatchQueue.main)
            .delay(for: 1.2, scheduler: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let this = self else { return }
                this.tableView.isHidden = false
                this.tableView.reloadData()
                this.activityIndicator.stopAnimating()
            }
            .store(in: &anyCancellable)
    }
}

extension InitialView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = viewModel.results.count
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: DemoViewCell = tableView.dequeueReusableCell(withIdentifier: DemoViewCell.id) as? DemoViewCell {
            let item = viewModel.results[indexPath.row]
            cell.configure(with: .init(name: item.name, price: item.price))
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = DetailsView()
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.$results
            .receive(on: DispatchQueue.main)
            .sink { model in
                detailsView.model.send(model[indexPath.row])
            }
            .store(in: &anyCancellable)
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
