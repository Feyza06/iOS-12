//
//  PostResponse.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//



import Foundation

struct PostResponse: Codable {
    let id: Int
    let petName: String
    let fee: Double
    let gender: String
    let petType: String
    let petBreed: String
    let birthday: Date
    let description: String
    let location: String
    let photo: Bool
    let status: String
    let createdAt: Date
    let userId: String
    
}


