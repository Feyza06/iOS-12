//
// NewMessage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** (tsType: Omit&lt;Message, &#39;id&#39;&gt;, schemaOptions: { title: &#39;NewMessage&#39;, exclude: [ &#39;id&#39; ] }) */
public struct NewMessage: Codable, JSONEncodable, Hashable {

    public var senderId: String
    public var recipientId: String
    public var postId: String
    public var content: String
    public var createdAt: Date

    public init(senderId: String, recipientId: String, postId: String, content: String, createdAt: Date) {
        self.senderId = senderId
        self.recipientId = recipientId
        self.postId = postId
        self.content = content
        self.createdAt = createdAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case senderId
        case recipientId
        case postId
        case content
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
        try container.encode(senderId, forKey: .senderId)
        try container.encode(recipientId, forKey: .recipientId)
        try container.encode(postId, forKey: .postId)
        try container.encode(content, forKey: .content)
        try container.encode(createdAt, forKey: .createdAt)
        var additionalPropertiesContainer = encoder.container(keyedBy: String.self)
        try additionalPropertiesContainer.encodeMap(additionalProperties)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        senderId = try container.decode(String.self, forKey: .senderId)
        recipientId = try container.decode(String.self, forKey: .recipientId)
        postId = try container.decode(String.self, forKey: .postId)
        content = try container.decode(String.self, forKey: .content)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        var nonAdditionalPropertyKeys = Set<String>()
        nonAdditionalPropertyKeys.insert("senderId")
        nonAdditionalPropertyKeys.insert("recipientId")
        nonAdditionalPropertyKeys.insert("postId")
        nonAdditionalPropertyKeys.insert("content")
        nonAdditionalPropertyKeys.insert("createdAt")
        let additionalPropertiesContainer = try decoder.container(keyedBy: String.self)
        additionalProperties = try additionalPropertiesContainer.decodeMap(AnyCodable.self, excludedKeys: nonAdditionalPropertyKeys)
    }
}

