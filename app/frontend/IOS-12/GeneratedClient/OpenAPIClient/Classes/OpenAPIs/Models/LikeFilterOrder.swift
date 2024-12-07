//
// LikeFilterOrder.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public enum LikeFilterOrder: Codable, JSONEncodable, Hashable {
    case typeString(String)
    case typeArrayString([String])

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeString(let value):
            try container.encode(value)
        case .typeArrayString(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .typeString(value)
        } else if let value = try? container.decode([String].self) {
            self = .typeArrayString(value)
        } else {
            throw DecodingError.typeMismatch(Self.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of LikeFilterOrder"))
        }
    }
}
