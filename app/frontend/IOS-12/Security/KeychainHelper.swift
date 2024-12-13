//
//  KeychainHelper.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.10.24.
//

import Foundation
import Security

/// A utility class for securely saving, reading, and deleting sensitive data using the iOS Keychain.
/// Keychain is a secure storage mechanism provided by iOS for handling small bits of sensitive data,
/// such as passwords, tokens, or cryptographic keys.
class KeychainHelper {

    /// A singleton instance of `KeychainHelper` to avoid creating multiple instances.
    static let standard = KeychainHelper()

    /// Private initializer to ensure this class can only be accessed via the singleton instance.
    private init() {}

    // MARK: - Save Data to Keychain

    /// Saves data to the Keychain for a given service and account.
    ///
    /// - Parameters:
    ///   - data: The data to store, typically a token or password, in `Data` format.
    ///   - service: A unique identifier for the Keychain item, often representing the app or feature.
    ///   - account: The account identifier, typically a username or similar credential.
    ///
    /// This method:
    /// 1. Creates a query dictionary with attributes like service, account, and data.
    /// 2. Deletes any existing item matching the service and account to prevent duplicates.
    /// 3. Adds the new data to the Keychain using `SecItemAdd`.
    func save(_ data: Data, service: String, account: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword, // Specifies this is a password item.
            kSecAttrService: service,           // Service name for grouping related credentials.
            kSecAttrAccount: account,           // Unique account identifier.
            kSecValueData: data                 // The actual data to store.
        ]

        // Remove any existing entry to avoid duplicates.
        SecItemDelete(query as CFDictionary)

        // Add the new item to the Keychain.
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error saving to Keychain: \(status)") // Log any error for debugging purposes.
        }
    }

    // MARK: - Read Data from Keychain

    /// Reads data from the Keychain for a given service and account.
    ///
    /// - Parameters:
    ///   - service: The unique identifier for the Keychain item to be retrieved.
    ///   - account: The account identifier for the Keychain item.
    /// - Returns: The stored data if found, otherwise `nil`.
    ///
    /// This method:
    /// 1. Creates a query dictionary to locate the specific item.
    /// 2. Requests the data from the Keychain using `SecItemCopyMatching`.
    /// 3. Returns the data or `nil` if not found or if an error occurs.
    func read(service: String, account: String) -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword, // Specifies this is a password item.
            kSecAttrService: service,           // Service name to locate the correct item.
            kSecAttrAccount: account,           // Account identifier to locate the correct item.
            kSecReturnData: true as CFBoolean,  // Specifies the result should include the data.
            kSecMatchLimit: kSecMatchLimitOne   // Ensures only one result is returned.
        ]

        var dataTypeRef: AnyObject? // A placeholder for the returned data.

        // Try to fetch the item from the Keychain.
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            return dataTypeRef as? Data // Return the data if the operation succeeds.
        } else if status != errSecItemNotFound {
            print("Error reading from Keychain: \(status)") // Log other errors for debugging.
        }

        return nil // Return nil if the item isn't found or an error occurs.
    }

    // MARK: - Delete Data from Keychain

    /// Deletes data from the Keychain for a given service and account.
    ///
    /// - Parameters:
    ///   - service: The unique identifier for the Keychain item to be deleted.
    ///   - account: The account identifier for the Keychain item to be deleted.
    ///
    /// This method:
    /// 1. Creates a query dictionary to locate the specific item.
    /// 2. Deletes the item from the Keychain using `SecItemDelete`.
    func delete(service: String, account: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword, // Specifies this is a password item.
            kSecAttrService: service,           // Service name to locate the correct item.
            kSecAttrAccount: account            // Account identifier to locate the correct item.
        ]

        // Try to delete the item from the Keychain.
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Error deleting from Keychain: \(status)") // Log any error for debugging.
        }
    }
}
