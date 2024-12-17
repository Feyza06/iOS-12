//
//  APIManager.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager() // singleton instance
    
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    private init(networkHandler: NetworkHandler = NetworkHandler(),
                 responseHandler: ResponseHandler = ResponseHandler()){
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: APIEndpointType,
        completion: @escaping ResultHandler<T>
    ) {
        // Validate the URL
        guard let url = type.url else {
                completion(.failure(.invalidURL))
                return
        }

        // Build a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        request.allHTTPHeaderFields = type.headers

        if let parameters = type.body {
            do{
                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                completion(.failure(.decoding(error)))
                return
            }
        }
    

        // perform network request
        networkHandler.requestDataAPI(url: request) { result in
                switch result {
                case .success(let data):
                    // parse the response data
                        self.responseHandler.parseResponseDecode(
                            data: data,
                            modelType: modelType,
                            completionHandler: completion
                        )
                    case .failure(let error):
                        // pass any errors 
                        completion(.failure(error))
                    }
                }
    }
}

