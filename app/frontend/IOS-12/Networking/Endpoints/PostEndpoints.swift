//
//  PostEndpoints.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//

import Foundation
import UIKit

struct UploadPostEndpoint: APIEndpointType, CustomURLRequestConvertible {
    var baseURL: String {"http://127.0.0.1:3000"}
    var path: String {"/posts"}
    
    var method: HTTPMethod {.POST}
    
    // multipart instead of JSON
    var body: Encodable? {nil}

    //var headers: [String: String]? { ["Content-Type": "application/json"] }
    
    var headers: [String: String]? {
        var defaultHeaders = [String: String]()
          
        // token authorization
          if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
             let token = String(data: tokenData, encoding: .utf8) {
              defaultHeaders["Authorization"] = "Bearer \(token)"
              print("tokenData: \(tokenData)")
          }

          return defaultHeaders
      }
   

    let postRequest: PostRequest
    let photo:  UIImage?
    
    init(postRequest: PostRequest, photo: UIImage?){
        self.postRequest = postRequest
        self.photo = photo
    }
    
    func asURLRequest() throws -> URLRequest{
        // ensure valid url
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        
        // Convert the PostRequest into fields for multipart form data
                let fields: [String: String] = [
                    "petName": postRequest.petName,
                    "fee": "\(postRequest.fee)",
                    "gender": postRequest.gender,
                    "petType": postRequest.petType,
                    "petBreed": postRequest.petBreed,
                    "birthday": ISO8601DateFormatter().string(from: postRequest.birthday),
                    "description": postRequest.description,
                    "location": postRequest.location,
                    "hasPhoto": photo != nil ? "true" : "false",
                    "userId": postRequest.userId
                ]
        
        // create the multipart request
        let request = MultipartFormDataHelper.createRequest(
            url: url,
            method: method.rawValue,
            fields: fields,
            image: photo, // pass the optional image
            imageFieldName: "photo", // backend expected field name
            imageFilename: "petphoto.jpg"
            )
        
        return request
    }
    
}

struct GetPostsEndpoint: APIEndpointType {
    var baseURL: String {"http://127.0.0.1:3000"}
    
    var path: String{"/posts"}
    
    var method: HTTPMethod {.GET}
    
    var body: Encodable? {return nil}
    
    var headers: [String: String]? {
        var defaultHeaders = [String: String]()
          
        // token authorization
          if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
             let token = String(data: tokenData, encoding: .utf8) {
              defaultHeaders["Authorization"] = "Bearer \(token)"
              print("tokenData: \(tokenData)")
              print("token: \(token)")
          }
       // defaultHeaders["Content-Type"] = "application/json"

          return defaultHeaders
      }
}






