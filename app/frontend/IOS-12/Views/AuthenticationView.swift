//
//  AuthenticationView.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 02.12.24.
//

import SwiftUI

enum AuthScreen {
    case home
    case login
    case signup
}


/// A view that manages the authentication process by displaying the appropriate screen
/// (e.g., home, login, or signup) based on user interaction.
///
/// The `AuthenticationView` acts as a hub for transitioning between authentication-related
/// screens. It handles navigation logic and provides the necessary environment objects
/// to child views.
struct AuthenticationView: View {
    /// The global application state, injected as an environment object.
    @EnvironmentObject var appState: AppState
    
    /// Tracks the currently active screen in the authentication flow.
    @State private var currentScreen: AuthScreen = .home
    
    var body: some View {
        // Switch between screens based on the value of `currentScreen`.
        switch currentScreen {
        case .home:
            // Display the home screen for authentication options (e.g., login, signup).
            HomeView(
                onLogin: { self.currentScreen = .login }, // Navigate to the login screen.
                onRegister: { self.currentScreen = .signup } // Navigate to the signup screen.
            )
        case .login:
            // Display the login screen.
            LoginView(
                onBack: { self.currentScreen = .home }, // Navigate back to the home screen.
                onRegister: { self.currentScreen = .signup } // Navigate to the signup screen.
            )
            .environmentObject(appState) // Pass the global app state to the LoginView.
        case .signup:
            SignUpView(
                onBack: { self.currentScreen = .home }, // Navigate back to the home screen.
                onLogin: { self.currentScreen = .login } // Navigate to the login screen.
            )
            .environmentObject(appState) // Pass the global app state to the SignUpView.
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    /// Provides a preview of the `AuthenticationView` with a sample `AppState`.
    static var previews: some View {
        AuthenticationView()
            .environmentObject(AppState())
    }
}
