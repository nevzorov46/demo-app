//
//  ConfigurationUI.swift
//  Demo
//
//  Created by Admin on 06.11.2023.
//


import UIKit

struct ConfigurationUI {
    
    static func configure() {
        configureNavigationBar()
    }
    
    static func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .mainThemeColor
    }
    
    
    // here another UI configuration such as TabBar etc..
}
