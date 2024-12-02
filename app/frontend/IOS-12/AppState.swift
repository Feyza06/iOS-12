//
//  AppState.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 26.11.24.
//

import SwiftUI

/// AppState manages the global state of the application, such as the user's login status.
class AppState: ObservableObject {
    /// Indicates whether the user is logged in.
    @Published var isLoggedIn: Bool = false

    /// Initializes the AppState and checks the user's login status.
    init() {
        checkLoginStatus()
    }

    /// Checks if the user is logged in by verifying the existence of a token in the Keychain.
    func checkLoginStatus() {
        if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
           let _ = String(data: tokenData, encoding: .utf8) {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }

    /// Logs the user out by deleting the token from the Keychain and updating the login status.
    func logout() {
        KeychainHelper.standard.delete(service: KeychainKeys.service, account: KeychainKeys.authToken)
        self.isLoggedIn = false
    }
}

// Constants for Keychain keys
struct KeychainKeys {
    static let service = "com.IOS-12App.identifier"
    static let authToken = "authToken"
}
