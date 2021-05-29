//
//  User.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/29/21.
//

import Foundation

struct User : Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
