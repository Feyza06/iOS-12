//
//  ContentView.swift
//  IOS-12
//
//  Created by Feyza Serin on 29.10.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isLoggedIn {
                NavigationView {
                    MainView()
                        .environmentObject(appState)
                }
            } else {
                HomeView()
                    .environmentObject(appState)
            }
        }
    }
}
