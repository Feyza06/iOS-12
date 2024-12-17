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
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // check for URLSession error
            if let error = error {
                completionHandler(.failure(.network(error)))
                return
            }
            
            //validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else{
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            // handle status code
            switch httpResponse.statusCode {
            case 200...299:
                break // successful response
            case 400..<500:
                completionHandler(.failure(.network(nil))) // client-side error
                return
            case 500...599:
                completionHandler(.failure(.serverError)) // server-side error
                return
            default:
                completionHandler(.failure(.invalidResponse)) // default case 
                return
            }
            
            
            // check for valid data
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            // return successful result
            completionHandler(.success(data))
            
        }
        session.resume()
        
    }
}
