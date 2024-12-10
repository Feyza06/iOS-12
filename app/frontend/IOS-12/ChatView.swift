import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
               
                Color(red: 1.0, green: 0.89, blue: 0.77)
                    .ignoresSafeArea()
                
                VStack {
                    Profile()
                        .padding(.top, 20)
                    
                    
                    ScrollView {
                        ForEach(viewModel.messages, id: \.id) { message in
                            MessageView(message: message)
                        }
                    }
                    .frame(maxWidth: .infinity)

                   
                    MessageField(onSend: { message in
                        if !message.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.sendMessage(message: message)
                        }
                    })
                    .padding()
                }
                .padding(.top)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}



    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }

