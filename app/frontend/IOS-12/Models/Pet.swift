//
//  Pet.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import Foundation

struct Pet: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let species: Species
    let gender: Gender
    let images: [String]
    let breed: Breed
    let weight: Double
    let description: String

    var isAdult: Bool {
        return age > 8
    }

    var displayType: String {
        isAdult ? "Adult" : species.youngName
    }

    init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        species: Species,
        gender: Gender,
        images: [String],
        breed: Breed,
        weight: Double,
        description: String
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.species = species
        self.gender = gender
        self.images = images
        self.breed = breed
        self.weight = weight
        self.description = description
    }
}
