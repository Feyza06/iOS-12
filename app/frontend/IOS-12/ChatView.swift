import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    let currentUserId: Int
    let otherUserId: Int
    let otherUsername: String
    let postId: Int
    
    @Environment(\.presentationMode) var presentationMode // Environment for navigation handling

    var body: some View {
        VStack {
            // Chat Messages
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message, currentUserId: String(currentUserId))
                            .id(message.id) // Allows scrolling to specific messages
                    }
                }
                .onChange(of: viewModel.messages.count) { _ in
                    // Scroll to the newest message
                    if let lastMessage = viewModel.messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }

            // Refresh button
            Button("Refresh") {
                viewModel.fetchMessages(
                    currentUserId: currentUserId,
                    otherUserId: otherUserId,
                    postId: postId
                )
            }
            .padding()

            MessageField { text in
                viewModel.sendMessage(
                    message: text,
                    currentUserId: currentUserId,
                    recipientId: otherUserId,
                    postId: postId
                )
            }
        }
        .onAppear {
            viewModel.fetchMessages(
                currentUserId: currentUserId,
                otherUserId: otherUserId,
                postId: postId
            )
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.primaryColor)
            }
        )
    }
}
    
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(
            currentUserId: 2,
            otherUserId: 3,
            otherUsername: "TimoMacher",
            postId: 1
        )
    }
}

