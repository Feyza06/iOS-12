//
//  SignUp.swift
//  IOS-12
//
//  Created by Feyza Serin on 01.11.24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var appState: AppState
    var onBack: () -> Void
    var onLogin: () -> Void
    
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var registrationSuccess = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    @State private var image: UIImage?
    @State private var isImagePickerPresented = false
    @State private var showActionSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
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
                    
                    VStack {
                        if let image = image {
                            // Display the selected image
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                .padding()
                        } else {
                            // Placeholder image
                            Image(systemName: "person.crop.circle.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.gray)
                                .padding()
                        }
                        // Button to add/change photo
                        Button(action: {
                            showActionSheet = true
                        }) {
                            Text(image == nil ? "Add Photo" : "Change Photo")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 40)
                                .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .cornerRadius(10)
                        }
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(
                                title: Text("Select Photo"),
                                message: Text("Choose a source"),
                                buttons: [
                                    .default(Text("Camera")) {
                                        sourceType = .camera
                                        isImagePickerPresented = true
                                    },
                                    .default(Text("Gallery")) {
                                        sourceType = .photoLibrary
                                        isImagePickerPresented = true
                                    },
                                    .cancel()
                                ]
                            )
                        }
                        // Present the image picker sheet
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(image: $image, sourceType: sourceType)
                        }
                    }
                    
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
                    
                    Button("Back", action: onBack)
                        .padding()
                    
                    HStack {
                        Text("Already have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                        
                        Button(action: onLogin) {
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
    
    // MARK: - Backend Operations
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
        
        // Prepare the URL for your backend
        guard let url = URL(string: "http://127.0.0.1:3000/users") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Boundary for the multipart/form-data
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Build the multipart/form-data body
        var body = Data()
        
        func appendFormField(name: String, value: String) {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        // Append form fields
        appendFormField(name: "firstName", value: firstName)
        appendFormField(name: "lastName", value: lastName)
        appendFormField(name: "username", value: username)
        appendFormField(name: "email", value: email)
        appendFormField(name: "password", value: password)
        
        // Append image file if available
        if let image = image,
           let imageData = image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
        }
        
        // Close the body
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        // Execute the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response."
                }
                return
            }
            
            DispatchQueue.main.async {
                if httpResponse.statusCode == 200 {
                    // Registration successful
                    self.registrationSuccess = true
                    self.errorMessage = nil
                    self.onLogin()
                } else {
                    if let data = data,
                       let responseMessage = try? JSONDecoder().decode([String: String].self, from: data),
                       let serverMessage = responseMessage["message"] {
                        self.errorMessage = "Registration failed: \(serverMessage)"
                    } else {
                        self.errorMessage = "Registration failed. Server responded with status code: \(httpResponse.statusCode)"
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
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView(
                onBack: {},
                onLogin: {}
            )
            .environmentObject(AppState())
        }
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
