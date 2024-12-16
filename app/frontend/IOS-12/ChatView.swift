import SwiftUI
struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    let currentUserId = "user1"
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 1.0, green: 0.89, blue: 0.77)
                    .ignoresSafeArea()
                
                VStack {
                    if let firstMessage = viewModel.messages.first {
                        let isCurrentUserSender = (firstMessage.senderId == currentUserId)
                        
                        Profile(senderId: isCurrentUserSender ? firstMessage.recipientId : firstMessage.senderId,
                                imageUrl: URL(string: isCurrentUserSender ?  "https://drive.google.com/uc?export=view&id=1K2_vBti-gyPMracSZHa7uZylxwHwlslz" : ""),
                                name: isCurrentUserSender ? "adele" : "sender")
                        
                        ScrollView {
                            ForEach(viewModel.messages) { message in
                                MessageView(message: message)
                            }
                        }
                        
                        Button(action: {
                            viewModel.fetchMessages()
                        }) {
                            Text("Refresh Chat")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .cornerRadius(50)
                                .padding(.bottom, -15)
                        }
                        
                        MessageField(onSend: { message in
                            if !message.trimmingCharacters(in: .whitespaces).isEmpty {
                                viewModel.sendMessage(message: message)
                            }
                            
                        })
                        .padding()
                    }
                }
                .onAppear {
                    viewModel.fetchMessages()
                }
            }
        }
    }
}
    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }

