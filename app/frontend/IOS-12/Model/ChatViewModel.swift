import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []

    func sendMessage(message: String, currentUserId: Int, recipientId: Int, postId: Int) {
        // The current user is the "senderId"
        // If you have the current user ID in `AppState`,
        // you might want to pass it in or store it in the view model.

        let newMessage = Message(
            id: nil,
            senderId: String(currentUserId),
            recipientId: String(recipientId),
            postId: String(postId), // or keep it as Int if your model is Int
            content: message,
            createdAt: ISO8601DateFormatter().string(from: Date())
        )

        // 1) Append locally (optimistic UI)
        messages.append(newMessage)

        // 2) Send to the server
        guard let url = URL(string: "http://127.0.0.1:3000/messages") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(newMessage)
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Failed to send message to server:", error)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print("Server returned status code \(httpResponse.statusCode)")
                }
            }.resume()
        } catch {
            print("Failed to encode message:", error)
        }
    }
    
    func fetchMessages(currentUserId: Int, otherUserId: Int, postId: Int) {
        let urlString = "http://127.0.0.1:3000/messages/between?" +
                        "senderId=\(currentUserId)&" +
                        "recipientId=\(otherUserId)&" +
                        "postId=\(postId)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching messages: \(String(describing: error))")
                return
            }
            do {
                let decoded = try JSONDecoder().decode([Message].self, from: data)
                DispatchQueue.main.async {
                    // Sort oldest-to-newest if not sorted by the backend
                    self.messages = decoded.sorted { $0.createdAt < $1.createdAt }
                }
            } catch {
                print("Failed to decode messages:", error)
            }
        }.resume()
    }
}
