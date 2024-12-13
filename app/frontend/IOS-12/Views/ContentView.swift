//
//  ContentView.swift
//  IOS-12
//
//  Created by Feyza Serin on 29.10.24.
//

import SwiftUI

/// The main view of the app that decides which screen to show based on the user's authentication state.
///
/// `ContentView` observes the global `AppState` to determine if the user is logged in.
/// Depending on the login status, it shows either the main application view (`MainView`) or the
/// authentication flow (`AuthenticationView`).
struct ContentView: View {
    /// Accesses the global app state, which holds the user's login status.
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isLoggedIn {
                // User is logged in; show the main content of the app.
                NavigationView {
                    MainView()
                        .environmentObject(appState) // Pass down the app state to child views.
                }
            } else {
                // User is not logged in; show the authentication flow.
                AuthenticationView()
                    .environmentObject(appState) // Pass down the app state to child views.
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    /// Provides a preview of `ContentView` for testing and UI design purposes.
    static var previews: some View {
        ContentView()
            .environmentObject(AppState()) // Inject a sample `AppState` for the preview.
    }
}
