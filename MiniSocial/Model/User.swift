//
//  User.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/29/21.
//

import Foundation
import SwiftUI

struct User : Decodable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    var statusImageFixed: some View {
        Image(systemName: isActive ? "largecircle.fill.circle" : "moon.circle.fill")
            .foregroundColor(isActive ? .green : .purple)
    }
    
    var statusImageDynamic: some View {
        Image(systemName: isActive ? "largecircle.fill.circle" : "moon.circle.fill")
            .resizable()
            .foregroundColor(isActive ? .green : .purple)
            .background(Circle().fill(Color.black))
    }
}
