//
//  OpenAPIClientAPI+Extensions.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 26.11.24.
//

import Foundation
import OpenAPIClient

extension PostControllerControllerAPI {
    
    // async wrapper for creating a new post
    static func createPost(newPost: NewPost) async throws -> Post {
        return try await withCheckedThrowingContinuation { continuation in
            
            postControllerControllerCreate(newPost: newPost){ data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: NSError(domain: "Unknown error", code: -1, userInfo: nil))
                }
                
            }
        }
        
    }
}


