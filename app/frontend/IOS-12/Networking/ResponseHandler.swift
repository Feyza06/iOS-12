//
//  ResponseHandler.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//
import Foundation

typealias ResultHandler<T> = (Result<T, NetworkError>) -> Void

class ResponseHandler {
    func parseResponseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: @escaping ResultHandler<T>
    ){
        do{
            let decodedResponse = try JSONDecoder().decode(modelType, from:data)
            completionHandler(.success(decodedResponse))
        } catch let decodingError as DecodingError{
            completionHandler(.failure(.decoding(decodingError)))
        } catch {
            completionHandler(.failure(.invalidData)) 
        }
    }
}

