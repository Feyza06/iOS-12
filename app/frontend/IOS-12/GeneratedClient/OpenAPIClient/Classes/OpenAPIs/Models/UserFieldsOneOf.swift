//
// UserFieldsOneOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct UserFieldsOneOf: Codable, JSONEncodable, Hashable {

    public var id: Bool?
    public var username: Bool?
    public var email: Bool?
    public var password: Bool?
    public var firstName: Bool?
    public var lastName: Bool?
    public var photo: Bool?

    public init(id: Bool? = nil, username: Bool? = nil, email: Bool? = nil, password: Bool? = nil, firstName: Bool? = nil, lastName: Bool? = nil, photo: Bool? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case username
        case email
        case password
        case firstName
        case lastName
        case photo
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
        try container.encodeIfPresent(username, forKey: .username)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(photo, forKey: .photo)
        var additionalPropertiesContainer = encoder.container(keyedBy: String.self)
        try additionalPropertiesContainer.encodeMap(additionalProperties)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Bool.self, forKey: .id)
        username = try container.decodeIfPresent(Bool.self, forKey: .username)
        email = try container.decodeIfPresent(Bool.self, forKey: .email)
        password = try container.decodeIfPresent(Bool.self, forKey: .password)
        firstName = try container.decodeIfPresent(Bool.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(Bool.self, forKey: .lastName)
        photo = try container.decodeIfPresent(Bool.self, forKey: .photo)
        var nonAdditionalPropertyKeys = Set<String>()
        nonAdditionalPropertyKeys.insert("id")
        nonAdditionalPropertyKeys.insert("username")
        nonAdditionalPropertyKeys.insert("email")
        nonAdditionalPropertyKeys.insert("password")
        nonAdditionalPropertyKeys.insert("firstName")
        nonAdditionalPropertyKeys.insert("lastName")
        nonAdditionalPropertyKeys.insert("photo")
        let additionalPropertiesContainer = try decoder.container(keyedBy: String.self)
        additionalProperties = try additionalPropertiesContainer.decodeMap(AnyCodable.self, excludedKeys: nonAdditionalPropertyKeys)
    }
}

