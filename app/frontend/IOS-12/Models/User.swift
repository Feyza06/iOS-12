//
//  User.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 03.12.24.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String?
    let photo: String?
}
