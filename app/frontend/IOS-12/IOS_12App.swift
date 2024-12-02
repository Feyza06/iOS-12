//
//  IOS_12App.swift
//  IOS-12
//
//  Created by Feyza Serin on 29.10.24.
//

import SwiftUI

@main
struct IOS_12App: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
