//
//  NetworkError.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//
import Foundation

enum NetworkError: LocalizedError{
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server response was invalid."
        case .invalidURL:
            return "The URL provided was invalid."
        case .invalidData:
            return "The data received from the server is invalid."
        case .network(let underlyingError):
            return underlyingError?.localizedDescription ?? "A network error occurred."
        case .decoding(let underlyingError):
            return underlyingError?.localizedDescription ?? "Failed to decode the response."
        case .serverError:
            return "A server error occurred."
        }
    }
}
