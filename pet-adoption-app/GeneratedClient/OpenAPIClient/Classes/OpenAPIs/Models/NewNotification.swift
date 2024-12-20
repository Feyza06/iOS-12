//
// NewNotification.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** (tsType: Omit&lt;Notification, &#39;id&#39;&gt;, schemaOptions: { title: &#39;NewNotification&#39;, exclude: [ &#39;id&#39; ] }) */
public struct NewNotification: Codable, JSONEncodable, Hashable {

    public var recipientId: String
    public var senderId: String
    public var postId: String
    public var type: String
    public var isRead: Bool
    public var createdAt: Date

    public init(recipientId: String, senderId: String, postId: String, type: String, isRead: Bool, createdAt: Date) {
        self.recipientId = recipientId
        self.senderId = senderId
        self.postId = postId
        self.type = type
        self.isRead = isRead
        self.createdAt = createdAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case recipientId
        case senderId
        case postId
        case type
        case isRead
        case createdAt
    }

    public var additionalProperties: [String: AnyCodable] = [:]

    public subscript(key: String) -> AnyCodable? {
        get {
            if let value = additionalProperties[key] {
                return value
            }
            return nil
        }

        set {
            additionalProperties[key] = newValue
        }
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recipientId, forKey: .recipientId)
        try container.encode(senderId, forKey: .senderId)
        try container.encode(postId, forKey: .postId)
        try container.encode(type, forKey: .type)
        try container.encode(isRead, forKey: .isRead)
        try container.encode(createdAt, forKey: .createdAt)
        var additionalPropertiesContainer = encoder.container(keyedBy: String.self)
        try additionalPropertiesContainer.encodeMap(additionalProperties)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        recipientId = try container.decode(String.self, forKey: .recipientId)
        senderId = try container.decode(String.self, forKey: .senderId)
        postId = try container.decode(String.self, forKey: .postId)
        type = try container.decode(String.self, forKey: .type)
        isRead = try container.decode(Bool.self, forKey: .isRead)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        var nonAdditionalPropertyKeys = Set<String>()
        nonAdditionalPropertyKeys.insert("recipientId")
        nonAdditionalPropertyKeys.insert("senderId")
        nonAdditionalPropertyKeys.insert("postId")
        nonAdditionalPropertyKeys.insert("type")
        nonAdditionalPropertyKeys.insert("isRead")
        nonAdditionalPropertyKeys.insert("createdAt")
        let additionalPropertiesContainer = try decoder.container(keyedBy: String.self)
        additionalProperties = try additionalPropertiesContainer.decodeMap(AnyCodable.self, excludedKeys: nonAdditionalPropertyKeys)
    }
}

