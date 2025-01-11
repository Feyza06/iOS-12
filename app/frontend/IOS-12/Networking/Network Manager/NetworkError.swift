//
//  NetworkError.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//


import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(URLError?)
    case decoding(DecodingError?)
    case serverError(statusCode: Int)
    
    // Centralized user-friendly error description
    var errorDescription: String? {
        var message: String
        switch self {
        case .invalidResponse:
            message = "The server response was invalid."
        case .invalidURL:
            message = "The URL provided was invalid."
        case .invalidData:
            message = "The data received from the server is invalid."
        case .network(let underlyingError):
            if let urlError = underlyingError {
                print("Network Error: \(urlError.localizedDescription) (\(urlError.code.rawValue))")
                           message = "A network error occurred: \(urlError.localizedDescription) (\(urlError.code.rawValue))"
                           switch urlError.code {
                           case .notConnectedToInternet:
                               message += "\nReason: The device is not connected to the internet. Please check your network connection."
                           case .timedOut:
                               message += "\nReason: The request timed out. Please try again later."
                           default:
                               message += "\nReason: General network error."
                           }
                       } else {
                           message = "A network error occurred, but no additional details are available."
                       }
            
            
            
           // message = underlyingError?.localizedDescription ?? "A network error occurred."
        case .decoding(let underlyingError):
            message = underlyingError?.localizedDescription ?? "Failed to decode the response."
        case .serverError(let statusCode):
            message = "A server error occurred with status code \(statusCode)."
        }
        
        // Log the error message for debugging
        print("Error: \(message)")
        return message
    }
}
