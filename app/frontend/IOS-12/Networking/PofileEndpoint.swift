//
//  PofileEndpoint.swift
//  IOS-12
//
//  Created by Anastasia Petri on 17.12.24.
//

import Foundation

struct ProfileEndpoint: APIEndpointType {
    var baseURL: String { "http://localhost:3000"}
    var path: String = ""
    var method: HTTPMethod = .GET
    var bpdy: Encodable? = nil
    
    var headers: [String: String]? {
        // Token dynamisch aus dem Keychain abrufen
        if let tokenData = KeychainHelper.standard.read(service: "com.yourapp.service", account: "authToken"),
           let token = String(data: tokenData, encoding: .utf8) {
            return ["Authorization": "Bearer \(token)"] // Header mit Token
        } else {
            print("Error: No token found in Keychain.")
            return nil
        }
        
        static  fetchProfile(userID: Int) -> ProfileEndpoint {
            return ProfileEndpoint(
                path: "/users/\(userID)",
                method: .GET
            )
        }
        
        
        
    }
}
