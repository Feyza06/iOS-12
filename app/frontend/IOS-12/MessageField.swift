//
//  MessageField.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 26.11.24.
//

import SwiftUI

struct MessageField: View {
    @State private var message = ""
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("your message"), text: $message)
            
            Button {
                print("message sent")
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(red:0.55, green:0.27, blue: 0.07))
                    .cornerRadius(50)
                    .padding()
            }
        }
        .padding(.horizontal)
        .background(Color(.gray).opacity(0.5))
        .cornerRadius(25)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
   
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            
            
            TextField("", text: $text)
            
        }
        
    }
    
}
