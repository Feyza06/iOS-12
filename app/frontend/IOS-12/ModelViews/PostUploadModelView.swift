//
//  PostUploadModelView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 26.11.24.
//


import Foundation
import OpenAPIClient
import UIKit


class PostUploadModelView: ObservableObject{
    
//    private let apiClient: (NewPost) async throws -> Post
//    
//    init(apiClient: @escaping (NewPost) async throws -> Post = PostControllerControllerAPi.createPost){
//        self.api = api
//    }
    
    // Bindable properties for the form
       @Published var petName: String = ""
       @Published var petType: String = ""
       @Published var petBreed: String = ""
       @Published var gender: String = "Male"
       @Published var photo: Bool = false
       @Published var description: String = ""
       @Published var preferredHome: String = ""
       @Published var status: String = "active" // Default status
       @Published var createdAt: Date = Date()
       @Published var userId: String? = "currentUserId" // Replace with dynamic user ID if needed

      
    
    // Feedback for UI
    @Published var isUploading: Bool = false
    @Published var successMessage: String?
    @Published var errorMessage: String?
    
    // Form validation
      var isFormValid: Bool {
          !petName.isEmpty &&
          !petType.isEmpty &&
          !petBreed.isEmpty &&
          !description.isEmpty &&
          !preferredHome.isEmpty
      }
    
    // Function to upload the post
    func uploadPost() {
        guard isFormValid else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        // Create a `Post` object
               let newPost = NewPost(
                   petName: petName,
                   petType: petType,
                   petBreed: petBreed,
                   gender: gender,
                   photo: photo,
                   description: description,
                   preferredHome: preferredHome,
                   status: status,
                   createdAt: createdAt,
                   userId: userId
               )
    
        Task {
            do {
                isUploading = true
                let uploadedPost = try await PostControllerControllerAPI.createPost(newPost: newPost)
                DispatchQueue.main.async {
                    self.successMessage = "Post upploaded successfully: \(uploadedPost.petName)"
                    self.resetForm()
                    self.isUploading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isUploading = false
                }
            }
        }
        
    }
    
    // Reset form fields
      func resetForm() {
          petName = ""
          petType = ""
          petBreed = ""
          gender = "Male"
          photo = false
          description = ""
          preferredHome = ""
          status = "active"
          createdAt = Date()
          userId = "currentUserId"
          successMessage = nil
          errorMessage = nil
      }
  }
    

    
    
  
    
    

