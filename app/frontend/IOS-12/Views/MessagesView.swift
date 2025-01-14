//
//  MessagesView.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 07.01.25.
//


import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var appState: AppState // Access the global AppState
    @State private var currentUserId: Int?    // Local variable to hold the user ID

    var body: some View {
        VStack {
            if let userId = currentUserId {
                Text("Current User ID: \(userId)")
                    .font(.headline)
                    .padding()
            } else {
                Text("No User ID Available")
                    .font(.headline)
                    .padding()
            }

            Text("MessagesView Content Goes Here")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.2)) // Styling
        .ignoresSafeArea()
        .onAppear {
            // Extract and prepare the user ID when the view appears
            self.currentUserId = appState.userId
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample AppState for preview
        MessagesView()
            .environmentObject(AppState())
    }
}
