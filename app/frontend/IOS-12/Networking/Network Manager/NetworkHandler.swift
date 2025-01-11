//
//  NetworkHandler.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//

import Foundation

/// For endpoints that need to build their own URLRequest (e.g., multipart uploads).
protocol CustomURLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

class NetworkHandler {
    func requestDataAPI(
        endpoint: APIEndpointType,
        completionHandler: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        if let customEndpoint = endpoint as? CustomURLRequestConvertible {
            do {
                let customRequest = try customEndpoint.asURLRequest()
                makeDataTask(request: customRequest, completionHandler: completionHandler)
            } catch {
                print("Error converting endpoint to URLRequest: \(error)")
                completionHandler(.failure(.network(error as! URLError)))
            }
        } else {
            // Fallback: build a standard JSON-based request
            guard let url = endpoint.url else {
                completionHandler(.failure(.invalidURL))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            
            if let parameters = endpoint.body {
                do {
                    request.httpBody = try JSONEncoder().encode(parameters)
                } catch {
                    print("Error encoding parameters: \(error)")
                    completionHandler(.failure(.decoding(error as! DecodingError)))
                    return
                }
            }
            
            request.allHTTPHeaderFields = endpoint.headers
            
            makeDataTask(request: request, completionHandler: completionHandler)
        }
    }
    
    /// Shared logic to create and run the data task, handle status codes, etc.
    private func makeDataTask(
        request: URLRequest,
        completionHandler: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Check for a lower-level network/transport error
            if let error = error {
                print("Network error occurred: \(error.localizedDescription)")
                completionHandler(.failure(.network(error as! URLError)))
                return
            }
            
            // Validate the response
            print("Invalid response received.")
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            // Check status code
            switch httpResponse.statusCode {
            case 200...299:
                break // success
            case 400..<500:
                completionHandler(.failure(.network(nil))) // client error
                return
            case 500...599:
                completionHandler(.failure(.serverError(statusCode: httpResponse.statusCode))) // server error
                return
            default:
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            // Check that we have data
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            // Return the data
            completionHandler(.success(data))
        }
        session.resume()
    }
}

