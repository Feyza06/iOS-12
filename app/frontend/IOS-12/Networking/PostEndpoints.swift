//
//  PostEndpoints.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//


struct UploadPostEndpoint: APIEndpointType {
    var baseURL: String {"http://localhost:3000"}
    var path: String {"/posts"}
    var method: HTTPMethod {.POST}
    var body: Encodable? {postRequest}
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    
    let postRequest: PostRequest
    
    init(postRequest: PostRequest){
        self.postRequest = postRequest
    }
    
}
