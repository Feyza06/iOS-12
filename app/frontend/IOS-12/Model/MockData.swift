//
//  MockData.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 10.12.24.
//


import Foundation

struct MockData {
    static var messages: [Message] = [
        Message(id: UUID().uuidString, text: "buna ziua ce faci mai", received: true, photoURL: "", timestamp: Date()),
        Message(id: UUID().uuidString, text: "sad pe scaun", received: false, photoURL: "", timestamp: Date()),
        Message(id: UUID().uuidString, text: "wow ce cool", received: true, photoURL: "", timestamp: Date())
    ]
}
