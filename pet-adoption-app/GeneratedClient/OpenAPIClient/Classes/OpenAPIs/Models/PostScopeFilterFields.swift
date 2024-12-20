//
// PostScopeFilterFields.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public enum PostScopeFilterFields: Codable, JSONEncodable, Hashable {
    case typeSet&lt;String&gt;(Set&lt;String&gt;)
    case type[String: AnyCodable]([String: AnyCodable])

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeSet&lt;String&gt;(let value):
            try container.encode(value)
        case .type[String: AnyCodable](let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Set&lt;String&gt;.self) {
            self = .typeSet&lt;String&gt;(value)
        } else if let value = try? container.decode([String: AnyCodable].self) {
            self = .type[String: AnyCodable](value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of PostScopeFilterFields"))
        }
    }
}

