import Foundation

struct Message: Identifiable, Codable {
    let id: Int?
    let senderId: String
    let recipientId: String
    let content: String
    let createdAt: String
}

