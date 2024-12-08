//
//  AppState.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 26.11.24.
//

import SwiftUI

/// A global state manager for the app that tracks and handles high-level states, such as the user's login status.
/// This class is an `ObservableObject`, which allows SwiftUI views to automatically update when the state changes.
class AppState: ObservableObject {
    /// A `@Published` property that tracks if the user is logged in.
    /// Views observing this property will automatically refresh when its value changes.
    @Published var isLoggedIn: Bool = false

    // MARK: - Initializer

    /// Initializes the AppState and performs necessary setup, such as checking the login status.
    /// The `checkLoginStatus()` function is called during initialization to ensure the app
    /// starts with the correct login state.
    init() {
        checkLoginStatus()
    }

    // MARK: - Login Status Management

    /// Checks if the user is logged in by verifying the presence of an authentication token
    /// in the Keychain. If a valid token is found, the `isLoggedIn` property is set to `true`.
    /// Otherwise, it is set to `false`.
    ///
    /// This function:
    /// 1. Reads the token from the Keychain using the `KeychainHelper`.
    /// 2. Decodes the token (if it exists) to verify its validity.
    /// 3. Updates the `isLoggedIn` property based on whether the token is valid.
    func checkLoginStatus() {
        // Attempt to retrieve the authentication token from the Keychain.
        if let tokenData = KeychainHelper.standard.read(
            service: KeychainKeys.service,
            account: KeychainKeys.authToken
        ),
        let _ = String(data: tokenData, encoding: .utf8) {
            // Token exists and is valid; set the user as logged in.
            self.isLoggedIn = true
        } else {
            // Token does not exist or is invalid; set the user as logged out.
            self.isLoggedIn = false
        }
    }

    /// Logs the user out by removing the authentication token from the Keychain
    /// and updating the `isLoggedIn` state to `false`.
    ///
    /// This function:
    /// 1. Deletes the token from the Keychain.
    /// 2. Updates the app's state to reflect the logged-out status.
    func logout() {
        // Remove the authentication token from the Keychain.
        KeychainHelper.standard.delete(
            service: KeychainKeys.service,
            account: KeychainKeys.authToken
        )
        // Update the state to reflect that the user is logged out.
        self.isLoggedIn = false
    }
}

// MARK: - Keychain Keys

/// A structure containing constants for Keychain keys used to identify stored data.
///
/// The `service` represents the app's unique identifier in the Keychain.
/// The `authToken` is the key under which the user's authentication token is stored.
struct KeychainKeys {
    /// A unique identifier for the app's Keychain items.
    static let service = "com.IOS-12App.identifier"

    /// The key used to store the user's authentication token.
    static let authToken = "authToken"
}
