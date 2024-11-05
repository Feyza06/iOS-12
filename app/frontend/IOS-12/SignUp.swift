//
//  SignUp.swift
//  IOS-12
//
//  Created by Feyza Serin on 01.11.24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var showErrorLabel = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(red: 0.55, green: 0.27, blue: 0.07)
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                
                Circle()
                    .scale(1.35)
                    .foregroundColor(Color(red: 1.0, green: 0.89, blue: 0.77))
                
                VStack {
                    Text("Sign-Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                    
                   
                    HStack {
                        TextField("Firstname", text: $firstname)
                            .padding()
                            .frame(width: 140, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                        
                        TextField("Lastname", text: $lastName)
                            .padding()
                            .frame(width: 140, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }
                    
                    TextField("Mobile", text: $phoneNumber)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    
                    TextField("E-Mail", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    
                    ZStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        } else {
                            SecureField("Password", text: $password)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        }
                        .padding(.leading, -185)
                    }
                    
                  
                    Button("Sign Up") {
                        if email.isEmpty || firstname.isEmpty || lastName.isEmpty || phoneNumber.isEmpty || password.isEmpty {
                            showErrorLabel = true
                        } else {
                            showErrorLabel = false
                            // Registrierung erfolgreich
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .cornerRadius(10)
                    
                  
                    if showErrorLabel {
                        Text("Please fill out all fields correctly!")
                            .foregroundColor(.red)
                            .padding()
                            .bold()
                    }
                    
                    // Link zur Login-Ansicht
                    HStack {
                        Text("Already have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        
                        NavigationLink(destination: LoginView()) {
                            Text("LOGIN")
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        }
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
