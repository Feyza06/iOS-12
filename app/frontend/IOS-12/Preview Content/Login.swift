//
//  Login.swift
//  IOS-12
//
//  Created by Feyza Serin on 31.10.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    var onBack: () -> Void
    var onRegister: () -> Void
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String? = nil
    @State private var isLoading = false  // For activity indicator

    var body: some View {
        NavigationView {
            ZStack {
                // Background and UI elements
                Color(red: 0.55, green: 0.27, blue: 0.07)
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
                        .keyboardType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isValidEmail(email) ? Color.clear : Color.red, lineWidth: 2)
                        )

                    HStack {
                        Group {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocapitalization(.none)

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        }
                    }
                    .frame(width: 300)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    if isLoading {
                        ProgressView()
                            .padding()
                    }

                    Button("Login") {
                        loginUser()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .cornerRadius(10)
                    .padding(.top, 5)

                    Button("Back", action: onBack)
                        .padding()
                    
                    HStack {
                        Text("Don't have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        
                        Button(action: onRegister) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        }
                    }
                    .padding(.top, 10)
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationBarHidden(true)
        }
    }

    @State private var isPasswordVisible = false

    // MARK: - Login Function
    private func loginUser() {
        // Clear previous error messages
        errorMessage = nil
        isLoading = true  // Start loading indicator

        // Input validation
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill out all fields."
            isLoading = false
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            isLoading = false
            return
        }

        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters."
            isLoading = false
            return
        }

        guard let url = URL(string: "http://127.0.0.1:3000/login") else {
            errorMessage = "Invalid URL"
            isLoading = false
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
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false  // Stop loading indicator
            }

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
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let loginResponse = try decoder.decode(LoginResponse.self, from: data)

                            // Save token to Keychain
                            if let tokenData = loginResponse.token.data(using: .utf8) {
                                KeychainHelper.standard.save(tokenData, service: KeychainKeys.service, account: KeychainKeys.authToken)
                            }

                            // Update app state
                            self.appState.isLoggedIn = true
                        } catch {
                            errorMessage = "Failed to parse server response."
                        }
                    } else {
                        errorMessage = "No data received from server."
                    }
                } else if httpResponse.statusCode == 401 {
                    // Invalid credentials
                    errorMessage = "Invalid Email or Password."
                } else {
                    // Handle other potential server errors
                    errorMessage = "Login failed with status code: \(httpResponse.statusCode)"
                }
            }
        }.resume()
    }

    // Email validation function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9.-]+)\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            onBack: {},
            onRegister: {}
        )
            .environmentObject(AppState())
    }
}
