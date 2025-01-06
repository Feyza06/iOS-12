//
//  APIManager.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager() // Singleton instance
    
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    private init(
        networkHandler: NetworkHandler = NetworkHandler(),
        responseHandler: ResponseHandler = ResponseHandler()
    ) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    /// For requests that expect a JSON-decoded response (e.g. returns a model).
    func request<T: Decodable>(
        modelType: T.Type,
        type: APIEndpointType,
        completion: @escaping ResultHandler<T>
    ) {
        networkHandler.requestDataAPI(endpoint: type) { result in
            switch result {
            case .success(let data):
                self.responseHandler.parseResponseDecode(
                    data: data,
                    modelType: modelType,
                    completionHandler: completion
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// For requests that don't return a JSON object (just success/failure).
    func requestDataVoid(
        endpoint: APIEndpointType,
        completion: @escaping (Result<Void, NetworkError>) -> Void
    ) {
        networkHandler.requestDataAPI(endpoint: endpoint) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
