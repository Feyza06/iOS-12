//
// PostPetViewTests.swift
//  IOS-12
//
// Created by Amira Kostadinova on 11.01.25.
//

import XCTest
@testable import IOS_12

// MARK: A mock implementation of 'PostViewModel'
/// This mock class allows us to simulate different behavior of the 'uploadPost' method without making real network calls.
class MockPostViewModel: PostViewModel {
    var uploadPostCalled = false
    var mockResult: Result<PostResponse, NetworkError>?

    override func uploadPost(
        postRequest: PostRequest,
        photo: UIImage?,
        completion: @escaping (Result<PostResponse, NetworkError>) -> Void
    ) {
        uploadPostCalled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let mockResult = self.mockResult {
                completion(mockResult)
            } else {
                completion(.failure(NetworkError.unknown))
            }
        }
    }

    /// Async wrapper for `uploadPost` using `withCheckedContinuation`
    func uploadPostAsync(
        postRequest: PostRequest,
        photo: UIImage?
    ) async throws -> PostResponse {
        try await withCheckedThrowingContinuation { continuation in
            self.uploadPost(postRequest: postRequest, photo: photo) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

final class PostPetViewTests: XCTestCase {
    var mockViewModel: MockPostViewModel!
    var postPetView: PostPetView!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockPostViewModel()
        postPetView = PostPetView()
    }
    
    // MARK: - Test Cases
    
    /// Test successful post upload
    func testUploadSuccess() async throws {
        // Arrange
        mockViewModel.mockResult = .success(
            PostResponse(
                id: 1,
                petName: "Buddy",
                fee: 50.0,
                gender: "Male",
                petType: "Dog",
                petBreed: "Golden Retriever",
                birthday: "2023-01-01",
                description: "Friendly and playful dog.",
                location: "New York",
                hasPhoto: true,
                photo: "https://example.com/photo.jpg",
                status: "active",
                createdAt: "2025-01-11",
                userId: "2"
            )
        )
        
        let mockImage = UIImage(systemName: "photo")
        
        // Act
        let response = try await mockViewModel.uploadPostAsync(
            postRequest: PostRequest(
                petName: "Buddy",
                fee: 50.0,
                gender: "Male",
                petType: "Dog",
                petBreed: "Golden Retriever",
                birthday: Date(),
                description: "Friendly and playful dog.",
                location: "New York",
                hasPhoto: true,
                userId: "2"
            ),
            photo: mockImage
        )
        
        // Assert
        XCTAssertTrue(mockViewModel.uploadPostCalled, "uploadPost should be called.")
        XCTAssertEqual(response.petName, "Buddy")
        XCTAssertEqual(response.fee, 50.0)
    }
    
  
    }
