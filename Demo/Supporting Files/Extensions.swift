//
//  Extensions.swift
//  Demo
//
//  Created by Admin on 06.11.2023.
//

import UIKit

extension UIColor {
    static let mainThemeColor = UIColor(named: "Main")
}

extension UIViewController {
    func setupNavigationController() {
        guard let navigationController = navigationController else { return }
        navigationItem.backButtonTitle = ""
    }
}
