//
//  NetworkHandler.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//

import Foundation

class NetworkHandler {
    
    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        // Log the request details
              print("Request URL: \(url.url?.absoluteString ?? "Invalid URL")")
              print("Request Headers: \(url.allHTTPHeaderFields ?? [:])")
              
              if let body = url.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                  print("Request Body: \(bodyString)")
              } else {
                  print("Request Body: None")
              }

        
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // check for URLSession error
            if let error = error {
                print("Network Error: \(error.localizedDescription)")
                completionHandler(.failure(self.mapError(error)))
                return
            }
            
            //validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else{
                print("Invalid response: No HTTPURLResponse received.")
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            // Log HTTP status code
            print("HTTP Status Code: \(httpResponse.statusCode)")
                       
            
            // handle status code
            switch httpResponse.statusCode {
            case 200...299:
                break // successful response
            case 400..<500:
                completionHandler(.failure(.network(nil))) // client-side error
                return
            case 500...599:
                completionHandler(.failure(.serverError(statusCode: httpResponse.statusCode))) // server-side error
                return
            default:
                completionHandler(.failure(.invalidResponse)) // default case 
                return
            }
            
            
            // check for valid data
            guard let data = data else {
                print("No data received from server.")
                completionHandler(.failure(.invalidData))
                return
            }
            
            // Log response body
                       if let responseBody = String(data: data, encoding: .utf8) {
                           print("Response Body: \(responseBody)")
                       } else {
                           print("Unable to decode response body.")
                       }
            
            // return successful result
            completionHandler(.success(data))
            
        }
        session.resume()
        
    }
    
    private func mapError(_ error: Error) -> NetworkError {
        if let urlError = error as? URLError {
            print("Mapped Network Error: \(urlError.localizedDescription)")
            return .network(urlError)
        } else if let decodingError = error as? DecodingError {
            print("Mapped Decoding Error: \(decodingError.localizedDescription)")
            return .decoding(decodingError)
        } else {
            print("Mapped to Invalid Response Error")
            return .invalidResponse
        }
    }
}
