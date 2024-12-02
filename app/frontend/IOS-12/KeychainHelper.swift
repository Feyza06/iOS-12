//
//  KeychainHelper.swift
//  IOS-12
//
//  Created by Your Name on Date.
//

import Foundation
import Security

class KeychainHelper {

    static let standard = KeychainHelper()

    private init() {}

    func save(_ data: Data, service: String, account: String) {
        // Create query
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data
        ]

        // Delete any existing items
        SecItemDelete(query as CFDictionary)

        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error saving to Keychain: \(status)")
        }
    }

    func read(service: String, account: String) -> Data? {
        // Create query
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true as CFBoolean,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?

        // Try to fetch the data
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            return dataTypeRef as? Data
        } else if status == errSecItemNotFound {
            // Item not found; handle gracefully without logging an error
            return nil
        } else {
            print("Error reading from Keychain: \(status)")
            return nil
        }
    }

    func delete(service: String, account: String) {
        // Create query
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]

        // Delete item from Keychain
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Error deleting from Keychain: \(status)")
        }
    }
}
