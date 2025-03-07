//
//  PostResponse.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.12.24.
//

import Foundation


struct PostRequest: Codable {
    let petName: String
    let fee: Double
    let gender: String
    let petType: String
    let petBreed: String
    let birthday: Date
    let description: String
    let location: String
    let hasPhoto: Bool
    let userId: String 
}

