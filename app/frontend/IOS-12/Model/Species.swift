//
//  Species.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import Foundation

enum Species: String, CaseIterable, Identifiable {
    case dog
    case cat
    case bird
    case rabbit
    case hamster

    var id: String { rawValue }

    var youngName: String {
        switch self {
        case .dog: return "Puppy"
        case .cat: return "Kitten"
        case .bird: return "Chick"
        case .rabbit: return "Bunny"
        case .hamster: return "Pup"
        }
    }
}
