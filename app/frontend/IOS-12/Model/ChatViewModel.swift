

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()

    let backendURL = "http://127.0.0.1:3000/messages"
    
    init() {
        fetchMessages()
    }
    
    func fetchMessages() {
        messages = MockData.messages
    }

    func sendMessage(message: String) {
      
        let newMessage = Message(
            id: UUID().uuidString,
            text: message,
            received: true, 
            photoURL: "",
            timestamp: Date()
        )

        DispatchQueue.main.async {
            self.messages.append(newMessage)
        }

    
    }
}
