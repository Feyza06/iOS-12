//
//  ConversationsViewModel.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 07.01.25.
//

import SwiftUI

struct Conversation: Identifiable, Codable {
    let id = UUID()          // Local unique ID for SwiftUI
    let userId: Int
    let username: String
    let lastMessage: String
    let createdAt: String
    let photo: String?
    let postId: Int 
}

class ConversationsViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []

    func fetchConversations(for userId: Int) {
        // 1) Construct the URL for:
        //    GET /messages/conversations/<userId>
        guard let url = URL(string: "http://127.0.0.1:3000/messages/conversations/\(userId)") else {
            print("Invalid URL")
            return
        }

        // 2) Run the network request
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Fetch error: \(String(describing: error?.localizedDescription))")
                return
            }

            // For debugging, you can print the raw response
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw conversations response: \(rawResponse)")
            }

            // 3) Decode the JSON into [Conversation]
            do {
                let decoded = try JSONDecoder().decode([Conversation].self, from: data)
                DispatchQueue.main.async {
                    self.conversations = decoded
                }
            } catch {
                print("Failed to decode [Conversation]: \(error)")
            }
        }.resume()
    }
}
