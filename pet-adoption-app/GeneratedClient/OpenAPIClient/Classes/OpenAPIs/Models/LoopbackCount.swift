//
// LoopbackCount.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct LoopbackCount: Codable, JSONEncodable, Hashable {

    public var count: Double?

    public init(count: Double? = nil) {
        self.count = count
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case count
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(count, forKey: .count)
    }
}

