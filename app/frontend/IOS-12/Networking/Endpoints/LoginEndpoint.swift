//
//  LoginEndpoint.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 26.12.24.
//

import Foundation

struct LoginRequestBody: Encodable {
    let email: String
    let password: String
}

struct LoginEndpoint: APIEndpointType {
    let baseURL: String = "http://127.0.0.1:3000"
    let path: String = "/login"
    let method: HTTPMethod = .POST
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    // Encodable body for login
    var body: Encodable? { loginBody }
    
    private let loginBody: LoginRequestBody
    
    init(email: String, password: String) {
        self.loginBody = LoginRequestBody(email: email, password: password)
    }
}
