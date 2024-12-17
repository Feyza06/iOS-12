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
    var headers: [String: String]? { ["Content-Type" : "application/json"]}
    
    static func fetchProfile(userID: Int) -> ProfileEndpoint {
            return ProfileEndpoint(
                path: "/users/\(userID)",
                method: .GET
            )
        }

    
    
    
}
