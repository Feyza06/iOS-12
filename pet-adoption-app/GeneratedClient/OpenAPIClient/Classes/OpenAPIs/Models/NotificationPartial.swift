//
// NotificationPartial.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** (tsType: Partial&lt;Notification&gt;, schemaOptions: { partial: true }) */
public struct NotificationPartial: Codable, JSONEncodable, Hashable {

    public var id: Double?
    public var recipientId: String?
    public var senderId: String?
    public var postId: String?
    public var type: String?
    public var isRead: Bool?
    public var createdAt: Date?

    public init(id: Double? = nil, recipientId: String? = nil, senderId: String? = nil, postId: String? = nil, type: String? = nil, isRead: Bool? = nil, createdAt: Date? = nil) {
        self.id = id
        self.recipientId = recipientId
        self.senderId = senderId
        self.postId = postId
        self.type = type
        self.isRead = isRead
        self.createdAt = createdAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
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
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(recipientId, forKey: .recipientId)
        try container.encodeIfPresent(senderId, forKey: .senderId)
        try container.encodeIfPresent(postId, forKey: .postId)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(isRead, forKey: .isRead)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        var additionalPropertiesContainer = encoder.container(keyedBy: String.self)
        try additionalPropertiesContainer.encodeMap(additionalProperties)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Double.self, forKey: .id)
        recipientId = try container.decodeIfPresent(String.self, forKey: .recipientId)
        senderId = try container.decodeIfPresent(String.self, forKey: .senderId)
        postId = try container.decodeIfPresent(String.self, forKey: .postId)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        isRead = try container.decodeIfPresent(Bool.self, forKey: .isRead)
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        var nonAdditionalPropertyKeys = Set<String>()
        nonAdditionalPropertyKeys.insert("id")
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

