//
//  Favourite.swift
//  IOS-12
//
//  Created by Lisa Mustafa on 16.12.24.
//

import Foundation

struct Favourite: Identifiable, Codable {
    let id: String // Favoriten-ID
    let name: String // Name des Favoriten
    let type: String // Typ (z. B. "Dog", "Cat")
}
