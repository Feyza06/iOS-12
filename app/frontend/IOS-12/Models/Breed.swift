//
//  Breed.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import Foundation

struct Breed: Identifiable {
    let id: UUID
    let name: String
    let species: Species
    let description: String

    init(id: UUID = UUID(), name: String, species: Species, description: String) {
        self.id = id
        self.name = name
        self.species = species
        self.description = description
    }
}
