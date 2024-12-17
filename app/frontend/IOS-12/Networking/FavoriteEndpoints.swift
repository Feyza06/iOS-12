////
////  FavoriteEndpoints.swift
////  IOS-12
////
////  Created by Amira Kostadinova on 16.12.24.
////
//
//struct CreateLikeEndpoint: APIEndpointType {
//    var baseURL: String {"http://127.0.0.1:3000"}
//    var path: String {"/posts"}
//    var method: HTTPMethod {.POST}
//    var body: Encodable? {postRequest}
//    
//    var headers: [String: String]? {
//          var defaultHeaders = ["Content-Type": "application/json"]
//          
//          if let tokenData = KeychainHelper.standard.read(service: "com.yourapp.auth", account: "userAuthToken"),
//             let token = String(data: tokenData, encoding: .utf8) {
//              defaultHeaders["Authorization"] = "Bearer \(token)"
//          }
//          
//          return defaultHeaders
//      }
//   
//    let like: Like // model
//    
//    init(postRequest: PostRequest){
//        self.postRequest = postRequest
//    }
//    
//}
