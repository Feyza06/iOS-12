//
//  ContentView.swift
//  IOS-12
//
//  Created by Feyza Serin on 29.10.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.725, blue: 0.467) //Beige
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                
                VStack {
                    // Titel
                    Text("Purrfect Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07)) // Brown
                        .padding(.top, 40)
                    
                    Image("LOGO")
                        .resizable()
                        .frame(width: 400, height: 350)
                        .padding(.leading, 0)
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    // Slogan-Text
                    Text("Where Every Paw Finds Its Purrfect Home")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        .padding(.top, 50)
                    
                    Spacer() // Space between button & text
                    
                    // register-button
                    Button(action: {
                        // Aktion für den Button
                    }) {
                        NavigationLink(destination: SignUpView()) {
                            Text("REGISTER")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300)
                                .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                        }
                        }
                        Button(action: {
                            print("Already have an account?")
                        }) {
                            // Link für bestehenden Account
                            NavigationLink(destination: LoginView()){
                                Text("Already have an account? LOGIN")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                            }
                        }
                        
                        Spacer()
                    }
                    .multilineTextAlignment(.center) // text in center
                }
            }
        }
    }

#Preview {
    ContentView()
}
