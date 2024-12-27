//
//  PofileEndpoint.swift
//  IOS-12
//
//  Created by Anastasia Petri on 17.12.24.
//

import Foundation

struct ProfileEndpoint: APIEndpointType {
    var baseURL: String { "http://localhost:3000" }
    var path: String
    var method: HTTPMethod
    var body: Encodable? { nil }

    var headers: [String: String]? {
        if let tokenData = KeychainHelper.standard.read(service: "com.yourapp.service", account: "authToken"),
           let token = String(data: tokenData, encoding: .utf8) {
            return ["Authorization": "Bearer \(token)"]
        } else {
            print("Error: No token found in Keychain.")
            return nil
        }
    }

    static func fetchProfile(userID: Int) -> ProfileEndpoint {
        return ProfileEndpoint(
            path: "/users/\(userID)",
            method: .GET
        )
    }
}
