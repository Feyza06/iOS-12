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
                    completion(.success(response))
                case .failure(let error):
                    print("Error uploading post: \(error)")
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
            }
        }
    }
}
