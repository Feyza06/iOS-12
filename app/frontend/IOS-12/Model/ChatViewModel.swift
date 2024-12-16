import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    let currentUserId = "user1"
    
    func fetchMessages() {
        print("Fetching messages from: http://127.0.0.1:3000/messages/between?senderId=\(currentUserId)&recipientId=user2")
        let url = URL(string: "http://127.0.0.1:3000/messages/between?senderId=\(currentUserId)&recipientId=user2")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching messages: \(String(describing: error))")
                return
            }

            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }
            
            do {
               
                let decodedMessages = try JSONDecoder().decode([Message].self, from: data)
                print("Fetched messages: \(decodedMessages)")
                
                DispatchQueue.main.async {
                    self.messages = decodedMessages
                }
            } catch {
                print("Failed to decode messages:", error)
            }
        }
        
        task.resume()
    }
    
    func sendMessage(message: String) {
        
        let newMessage = Message(
            id: nil,
            senderId: currentUserId,
            recipientId: "user2",
            content: message,
            createdAt: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        )
       
        messages.append(newMessage)
        
       
       
    }
    

}
