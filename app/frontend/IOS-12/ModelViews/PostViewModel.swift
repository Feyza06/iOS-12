//
//  PostViewModel.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//

import Foundation
import SwiftUI

class PostViewModel: ObservableObject {
    
    @Published var isUploading: Bool = false
    @Published var uploadSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var uploadedPost: PostResponse?
    @Published var isLoading = false
    @Published var posts: [PostResponse] = []
    @Published var filteredPosts: [PostResponse] = []
    @Published var selectedPetType: String? = nil
    
    
    // Image Handling States
    //@Published var image: UIImage?
    //@Published var isImagePickerPresented = false
    //@Published var showActionSheet = false
    //@Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func uploadPost(
        postRequest: PostRequest,
        photo: UIImage?,
        completion: @escaping (Result<PostResponse, NetworkError>) -> Void
    ) {
        // Initialize the endpoint
        let endpoint = UploadPostEndpoint(postRequest: postRequest, photo: photo)
        
        
        // Begin uploading
        isUploading = true
        errorMessage = nil
        uploadSuccess = false
        
        
        //  APIManager to make the request
        APIManager.shared.request(
            modelType: PostResponse.self, // The expected response type
            type: endpoint
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isUploading = false
                
                switch result {
                case .success(let response):
                    print("Upload successful: \(response)")
                    self?.uploadSuccess = true
                    self?.uploadedPost = response
                    self?.uploadedPost = response
                    completion(.success(response))
                case .failure(let error):
                    // Use NetworkError's errorDescription for logging and setting the error message
                                   self?.errorMessage = error.errorDescription
                                   completion(.failure(error))
               }
            }
        }
    }
}
