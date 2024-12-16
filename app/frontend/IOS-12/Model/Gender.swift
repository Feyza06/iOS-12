//
//  Gender.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male
    case female

    var id: String { rawValue }
}
