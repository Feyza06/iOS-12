//
//  IOS_12App.swift
//  IOS-12
//
//  Created by Feyza Serin on 29.10.24.
//

import SwiftUI

/// The entry point for the iOS application.
///
/// This struct conforms to the `App` protocol, which is required for SwiftUI-based apps.
/// It sets up the app's main scene, initializes the global state (`AppState`),
/// and provides it as an `@EnvironmentObject` to the rest of the app.
@main
struct IOS_12App: App {
    /// A global state object to manage application-wide data and logic, such as user login status.
    /// The `@StateObject` property wrapper ensures this object is created once
    /// and managed by SwiftUI for the lifetime of the app.
    @StateObject private var appState = AppState()

    var body: some Scene {
        // Defines the main scene for the app.
        WindowGroup {
            // The root view of the app, which dynamically displays
            // either the authentication flow or the main content based on the user's login status.

            ContentView()
                .environmentObject(appState) // Injects the global state into the app's view hierarchy.

//            ContentView()
//                .environmentObject(appState) // Injects the global state into the app's view hierarchy.
            AuthenticationView()
                .environmentObject(appState)

        }
    }
}
