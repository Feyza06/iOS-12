//
//  PostViewModel.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var isUploading: Bool = false
    @Published var uploadSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var uploadedPost: PostResponse?
    @Published var isLoading = false
    
    @Published var posts: [PostResponse] = []
    @Published var filteredPosts: [PostResponse] = []
    @Published var selectedPetType: String? = nil
    
    func uploadPost(postRequest: PostRequest, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        // Initialize the endpoint
        let endpoint = UploadPostEndpoint(postRequest: postRequest)
        
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
                    completion(.success(response))
                case .failure(let error):
                    print("Error uploading post: \(error)")
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    
    func fetchPosts(){
        isLoading = true
        errorMessage = nil
        
        let endpoint = FetchPostsEndpoint()
        
        APIManager.shared.request(modelType: [PostResponse].self, type: endpoint
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let posts):
                    print("Posts fetched successfully: \(posts)")
                    self?.posts = posts // Save posts to the state
                    self?.filteredPosts = posts // Initially, show all posts
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                    self?.errorMessage = error.localizedDescription // Show error message
                }
            }
        }
    }

        
    
    
    func filterPosts(){
        if let selectedPetType = selectedPetType{
            filteredPosts = posts.filter { $0.petType == selectedPetType}
        } else{
            filteredPosts = posts
        }
    }
}
