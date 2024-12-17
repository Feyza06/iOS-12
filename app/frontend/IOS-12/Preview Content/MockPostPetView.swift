////
////  MockPostPetView.swift
////  IOS-12
////
////  Created by Amira Kostadinova on 11.12.24.
////
//
//import Foundation
//
//class MockPostViewModel:PostViewModel {
//    override func uploadPost(postRequest: PostRequest, completion: @escaping (Result<PostResponse, Error>) -> Void){
//       
//        // simulating a network response
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            
//            // mock a successful response
//            let mockResponse = PostResponse(
//                id: 1,
//                               petName: postRequest.petName,
//                               fee: postRequest.fee,
//                               gender: postRequest.gender,
//                               petType: postRequest.petType,
//                               petBreed: postRequest.petBreed,
//                               birthday: postRequest.birthday,
//                               description: postRequest.description,
//                               location: postRequest.location,
//                               photo: postRequest.photo,
//                               status: "Active",
//                               createdAt: Date(),
//                               userId: "12345"
//            )
//            completion(.success(mockResponse))
//        }
//    }
//}
