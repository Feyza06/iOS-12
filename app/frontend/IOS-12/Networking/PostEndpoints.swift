//
//  PostEndpoints.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//


struct UploadPostEndpoint: APIEndpointType {
    var baseURL: String {"http://127.0.0.1:3000"}
    var path: String {"/posts"}
    var method: HTTPMethod {.POST}
    var body: Encodable? {postRequest}
    
    var headers: [String: String]? {
          var defaultHeaders = ["Content-Type": "application/json"]
          
          if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
             let token = String(data: tokenData, encoding: .utf8) {
              defaultHeaders["Authorization"] = "Bearer \(token)"
              print("tokenData: \(tokenData)")
          }

          return defaultHeaders
      }
   
    let postRequest: PostRequest
    
    init(postRequest: PostRequest){
        self.postRequest = postRequest
    }
    
}

struct FetchPostsEndpoint: APIEndpointType {
    var body: (any Encodable)?
    
    var baseURL: String {"http://127.0.0.1:3000"}
    var path: String {"/posts"}
    var method: HTTPMethod {.GET}
    
    var headers: [String: String]? {
          var defaultHeaders = ["Content-Type": "application/json"]
          
          if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
             let token = String(data: tokenData, encoding: .utf8) {
              defaultHeaders["Authorization"] = "Bearer \(token)"
              print("tokenData: \(tokenData)")
          }

          return defaultHeaders
      }
    
    init() {}
   
    
   
    
}
