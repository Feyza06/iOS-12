//
//  Login.swift
//  IOS-12
//
//  Created by Feyza Serin on 31.10.24.
//

import SwiftUI
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showingLoginScreen = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red:0.55, green:0.27, blue: 0.07)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(Color(red: 1.0, green: 0.89, blue: 0.77))
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .border(.red, width: CGFloat(wrongEmail))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Login") {
                        loginUser()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(red:0.55, green:0.27, blue: 0.07))
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in as \(email)"), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Login Function
    private func loginUser() {
        // Clear previous error messages
        errorMessage = nil
        wrongEmail = 0
        wrongPassword = 0
        
        guard let url = URL(string: "http://127.0.0.1:3000/login") else {
            errorMessage = "Invalid URL"
            return
        }
        
        let loginData: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: [])
        } catch {
            errorMessage = "Failed to encode login data."
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    errorMessage = "Invalid server response."
                }
                return
            }
            
            DispatchQueue.main.async {
                if httpResponse.statusCode == 200 {
                    // Login successful, navigate to next screen
                    showingLoginScreen = true
                } else if httpResponse.statusCode == 401 {
                    // Invalid credentials
                    errorMessage = "Invalid Email or Password."
                    wrongEmail = 2
                    wrongPassword = 2
                } else {
                    // Handle other potential server errors
                    errorMessage = "Login failed with status code: \(httpResponse.statusCode)"
                }
            }
        }.resume()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


// Test!
