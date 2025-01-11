//
//  ConversationsView.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 07.01.25.
//

import SwiftUI

struct ConversationsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = ConversationsViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                // Search bar (optional)
                HStack {
                    TextField("Search Conversations", text: .constant("")) // Add a search binding if needed
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .regular))
                        .padding()
                    Image(systemName: "magnifyingglass")
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(Color.primaryColor)
                        .cornerRadius(10)
                }
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.lightGrey, lineWidth: 1))
                .padding()

                // Conversations List
                List(viewModel.conversations) { convo in
                    NavigationLink(
                        destination: ChatView(
                            currentUserId: appState.userId ?? 0,
                            otherUserId: convo.userId,
                            otherUsername: convo.username,
                            postId: Int(convo.postId) ?? 0
                        )
                    ) {
                        HStack(spacing: 16) {
                            AsyncImage(url: buildImageURL(from: convo.photo)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                case .failure:
                                    Image(systemName: "person")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(convo.username)
                                    .font(.headline)
                                Text(convo.lastMessage)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(formatDate(convo.createdAt))
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Conversations", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.primaryColor)
                }
            )
            .onAppear {
                if let currentUserId = appState.userId {
                    viewModel.fetchConversations(for: currentUserId)
                } else {
                    print("No userId found in AppState.")
                }
            }
        }
    }

    // Helper function to format the date
    private func formatDate(_ date: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let isoDate = formatter.date(from: date) else { return date }
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .short
        displayFormatter.timeStyle = .short
        return displayFormatter.string(from: isoDate)
    }
    
    func buildImageURL(from path: String?) -> URL? {
        guard let path = path, !path.isEmpty else {
            return nil
        }
        // Adjust base URL as per your server configuration
        let baseURL = "http://127.0.0.1:3000" // Replace with your server's URL
        return URL(string: path.starts(with: "http") ? path : baseURL + path)
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample AppState
        let testAppState = AppState()
        testAppState.userId = 2

        return ConversationsView()
            .environmentObject(testAppState)
    }
}
