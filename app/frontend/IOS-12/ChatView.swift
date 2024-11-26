//
//  ChatView.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 26.11.24.
//

import SwiftUI


class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    @Published var mockData = [
        Message(id:"1", text: "hello from the other side", received:false, photoURL: "", timestap: Date()),
        Message(id:"2", text: "i must have called a thousand times", received:true, photoURL: "", timestap: Date()),
        Message(id:"3", text: "to tell you, im sorry", received:false, photoURL: "", timestap: Date()),
        Message(id:"4", text: "for everything that i've done", received:true, photoURL: "", timestap: Date()),
        Message(id:"5", text:"But when I call, you never seem to be home", received:false, photoURL: "", timestap: Date()),
        Message(id:"6", text: "hello from the outside", received:true, photoURL: "", timestap: Date()),
        Message(id:"7", text:"at least I can say that I've tried", received:false, photoURL: "", timestap: Date()),
        //Message(id:"8", text: "to tell you I'm sorry for breaking your heart", received:true, photoURL: "", timestap: Date()),
    ]
    
    
    
}




struct ChatView: View {
    
    
    @StateObject var chatViewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.89, blue: 0.77)
                .ignoresSafeArea()
           
            VStack(spacing: 25) {
                Text("Chat")
                    .font(.title)
                    .padding()
                ForEach(chatViewModel.mockData) { message in
                    MessageView(message: message)
                }
            }
        }
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View{
        ChatView()
    }
}
