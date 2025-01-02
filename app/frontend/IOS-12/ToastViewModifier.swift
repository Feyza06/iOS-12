//
//  ToastViewModifier.swift
//  IOS-12
//
//  Created by Lisa Mustafa on 28.12.24.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: TimeInterval = 2.0

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                }
            }
        }
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: String) -> some View {
        self.modifier(ToastViewModifier(isPresented: isPresented, message: message))
    }
}
