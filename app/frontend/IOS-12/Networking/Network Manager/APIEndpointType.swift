//
//  APIEndpointType.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//
import Foundation


protocol APIEndpointType {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var body: Encodable? {get}
    var headers: [String: String]? {get}
}

// Provide default implementation for `url`
extension APIEndpointType {
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
    
    
    
    


