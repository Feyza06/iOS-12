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
    
    init(networkHandler: NetworkHandler = NetworkHandler(),
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
                let encoder = JSONEncoder()
                //encoder.dateEncodingStrategy = .iso8601 // Set date encoding to ISO 8601
                
                
                let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "yyyy-MM-dd" // Matches the "date" format
                       encoder.dateEncodingStrategy = .formatted(dateFormatter)
                       
                    
                request.httpBody = try encoder.encode(parameters)
            } catch {
                completion(.failure(.decoding(error as? DecodingError)))
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
                   
                    // pass the mapped error to the completion handler
                    completion(.failure(error))
                    }
                }
    }
}


// Handle Multipart form data
//
//extension APIManager {
//    func upload<T: Decodable> (
//        modelType: T.Type,
//        type: APIEndpointType,
//        parameters: [String: String] = [:],
//        files: [String: Data] = [:],
//        completion: @escaping ResultHandler<T>
//    ){
//        
//    }
//}
