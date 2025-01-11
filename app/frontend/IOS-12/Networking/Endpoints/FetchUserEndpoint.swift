//
//  FetchUserEndpoint.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 28.12.24.
//

import Foundation

struct FetchUserEndpoint: APIEndpointType {
    let baseURL: String = "http://127.0.0.1:3000"
    let userId: Int
    
    // Build a path like /users/123
    var path: String { "/users/\(userId)" }
    
    let method: HTTPMethod = .GET
    
    var headers: [String: String]? {
        // Try reading the token from Keychain
        if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
           let token = String(data: tokenData, encoding: .utf8) {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
    
    var body: Encodable? { nil }
}
