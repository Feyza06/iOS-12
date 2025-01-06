//
//  AppStateTests.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 10.12.24.
//

import XCTest
@testable import IOS_12  // Assuming your module is named IOS_12

class AppStateTests: XCTestCase {
    var appState: AppState!
    
    override func setUp() {
        super.setUp()
        // Initialize a fresh instance of AppState before each test
        appState = AppState()
    }

    override func tearDown() {
        // Reset if needed
        appState = nil
        super.tearDown()
    }

    func testInitialLoginStatus() {
        // By default, we might expect a user to be logged out
        XCTAssertFalse(appState.isLoggedIn, "User should not be logged in initially.")
    }

    func testTokenExpirationCheck() {
        // Example: Provide a mocked (expired) token and verify isTokenExpired
        let expiredToken = "<someExpiredJWT>"
        XCTAssertTrue(appState.isTokenExpired(token: expiredToken), "Should detect expired token correctly.")
    }

    func testValidTokenUpdatesLoginStatus() {
        // Mock a valid token and Keychain
        let validToken = "<someValidJWT>"
        let tokenData = validToken.data(using: .utf8)!
        
        // Write token to Keychain (you might need a mock KeychainHelper for isolation)
        KeychainHelper.standard.save(tokenData, service: KeychainKeys.service, account: KeychainKeys.authToken)
        
        // Call checkLoginStatus which should read token and set logged in status
        appState.checkLoginStatus()
        
        XCTAssertTrue(appState.isLoggedIn, "User should be logged in if a valid token is found.")
    }
}
