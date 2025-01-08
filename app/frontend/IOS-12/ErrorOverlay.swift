//
//  ErrorOverlay.swift
//  IOS-12
//
//  Created by Feyza Serin on 13.12.24.
//

import SwiftUI

struct MessageOverlay: View {
    @Binding var isVisible: Bool
    var message: String
    var type: OverlayType
    
    enum OverlayType {
        case success
        case error
    }

    var body: some View {
        if isVisible {
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: type == .success ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(type == .success ? .green : .yellow)
                                        
                    Text(message)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Text(type == .success ? "OK" : "Dismiss")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(type == .success ? Color.green : Color.red)
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
        
         //Error Example
                    MessageOverlay(isVisible: .constant(true), message: "An Error occurred, please try again!", type: .error)
                        .previewLayout(.sizeThatFits)
                        .padding()
                    
                    // Success Example
                    MessageOverlay(isVisible: .constant(true), message: "Operation completed successfully!", type: .success)
                        .previewLayout(.sizeThatFits)
                        .padding()
    }
}
