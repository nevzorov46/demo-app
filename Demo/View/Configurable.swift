//
//  Configurable.swift
//  Demo
//
//  Created by Admin on 07.11.2023.
//

import Foundation

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}
