//
//  PostResponse.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//



import Foundation



struct PostResponse: Codable, Identifiable {
    
    let id: Int
    let petName: String
    let fee: Double
    let gender: String
    let petType: String
    let petBreed: String
    let birthday: String // date
    let description: String
    let location: String
    let hasPhoto: Bool
    let photo: String?
    let status: String
    let createdAt: String // date
   // let userId: String
    
}
