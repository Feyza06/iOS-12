//
//  ErrorOverlay.swift
//  IOS-12
//
//  Created by Feyza Serin on 13.12.24.
//

import SwiftUI

struct MessageOverlay:View {
    @Binding var isVisible: Bool
    var isSuccess: Bool
    var message: String

    var body: some View {
        if isVisible {
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: isSuccess ?  "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundColor(isSuccess ? .green : .yellow)
                    
                    Text(message)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Text(isSuccess ? "OK" : "Dismiss")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isSuccess ? Color.green : Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
        }
   
    }
    
}
struct MessageOverlay_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack{
            MessageOverlay(isVisible: .constant(true),isSuccess: false,  message: "An Error occured, please try again!")                
            MessageOverlay(isVisible: .constant(true), isSuccess: true, message: "Post uploaded successfully!")
        }
        
       
        
    }
}
