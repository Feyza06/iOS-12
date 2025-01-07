//
//  RegisterUserWithImageEndpoint.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 26.12.24.
//

import Foundation
import UIKit

struct RegisterUserWithImageEndpoint: APIEndpointType, CustomURLRequestConvertible {
    
    let baseURL: String = "http://127.0.0.1:3000"
    let path: String = "/users"
    let method: HTTPMethod = .POST
    
    // We won't provide a JSON-encoded body, because we use multipart.
    var body: Encodable? { nil }
    
    // We'll rely on `MultipartFormDataHelper` to set our Content-Type header.
    // So here we can leave headers nil or set only non-content-type headers if needed.
    var headers: [String: String]? {
        nil
    }
    
    // Properties for user registration
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let password: String
    let image: UIImage?
    
    // This is where we build the actual URLRequest using `MultipartFormDataHelper`
    func asURLRequest() throws -> URLRequest {
        // Make sure the URL is valid
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        
        // Prepare the fields you want to send
        let fields: [String: String] = [
            "firstName": firstName,
            "lastName": lastName,
            "username": username,
            "email": email,
            "password": password
        ]
        
        // Use your helper to build the multipart form-data request
        let request = MultipartFormDataHelper.createRequest(
            url: url,
            method: method.rawValue,  // "POST"
            fields: fields,
            image: image,
            imageFieldName: "photo",   // Matches your LoopBack code
            imageFilename: "image.jpg"
            // boundary will be automatically created in `createRequest()`
        )
        
        return request
    }
}
