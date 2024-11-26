//
//  Message.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 26.11.24.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var photoURL: String
    var timestap: Date
}
    

