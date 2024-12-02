//
//  AuthenticationView.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 02.12.24.
//

import SwiftUI

import SwiftUI

enum AuthScreen {
    case home
    case login
    case signup
}

struct AuthenticationView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentScreen: AuthScreen = .home
    
    var body: some View {
        switch currentScreen {
        case .home:
            HomeView(
                onLogin: { self.currentScreen = .login },
                onRegister: { self.currentScreen = .signup }
            )
        case .login:
            LoginView(
                onBack: { self.currentScreen = .home },
                onRegister: { self.currentScreen = .signup }
            )
            .environmentObject(appState)
        case .signup:
            SignUpView(
                onBack: { self.currentScreen = .home },
                onLogin: { self.currentScreen = .login }
            )
            .environmentObject(appState)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(AppState())
    }
}
