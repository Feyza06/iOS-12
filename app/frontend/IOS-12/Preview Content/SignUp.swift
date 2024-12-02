//
//  SignUp.swift
//  IOS-12
//
//  Created by Feyza Serin on 01.11.24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var registrationSuccess = false
    @State private var errorMessage: String?
    @State private var isLoading = false  // For activity indicator

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
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))

                    HStack {
                        TextField("First Name", text: $firstName)
                            .padding()
                            .frame(height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .foregroundColor(.black)

                        TextField("Last Name", text: $lastName)
                            .padding()
                            .frame(height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }
                    .frame(width: 300)

                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .autocapitalization(.none)

                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding(.bottom, 5)

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
                        .foregroundColor(.black)
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
                    } else if registrationSuccess {
                        Text("Registration successful!")
                            .foregroundColor(.green)
                            .padding()
                            .bold()
                    }

                    if isLoading {
                        ProgressView()
                            .padding()
                    }

                    Button("Sign Up") {
                        registerUser()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .cornerRadius(10)
                    .padding(.top, 5)

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
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func registerUser() {
        // Clear previous messages
        errorMessage = nil
        registrationSuccess = false
        isLoading = true

        // Input validation
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
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

        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "username": username,
            "email": email,
            "password": password
        ]

        guard let url = URL(string: "http://127.0.0.1:3000/users") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
        } catch {
            errorMessage = "Error serializing JSON: \(error.localizedDescription)"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    errorMessage = "Invalid response."
                }
                return
            }

            DispatchQueue.main.async {
                if httpResponse.statusCode == 200 {
                    registrationSuccess = true
                    errorMessage = nil
                    // Optionally, navigate to LoginView or log in automatically
                } else {
                    if let data = data,
                       let responseMessage = try? JSONDecoder().decode([String: String].self, from: data),
                       let serverMessage = responseMessage["message"] {
                        errorMessage = "Registration failed: \(serverMessage)"
                    } else {
                        errorMessage = "Registration failed. Server responded with status code: \(httpResponse.statusCode)"
                    }
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
