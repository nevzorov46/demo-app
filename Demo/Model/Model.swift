//
//  Model.swift
//  Demo
//
//  Created by Admin on 06.11.2023.
//

import Foundation

struct ResultModel: Decodable {
    var items: [ItemResultModel]
}

struct ItemResultModel: Decodable {
    var name: String
    var price: Int
    var keywords: [String]
}
