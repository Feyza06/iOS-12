//
//  ErrorOverlay.swift
//  IOS-12
//
//  Created by Feyza Serin on 13.12.24.
//

import SwiftUI

struct ErrorOverlay: View {
    @Binding var isVisible: Bool
    var message: String

    var body: some View {
        if isVisible {
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text(message)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Text("Dismiss")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
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
