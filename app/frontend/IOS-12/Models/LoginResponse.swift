//
//  LoginResponse.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 03.12.24.
//


import Foundation

struct LoginResponse: Codable {
    let token: String
    let user: User
}