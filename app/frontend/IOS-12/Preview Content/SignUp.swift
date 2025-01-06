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
    
    // MARK: - Background Operations
    private func registerUser() {
        // Clear previous messages
        errorMessage = nil
        registrationSuccess = false
        isLoading = true
        
        // Validation
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
        
        // Use the new APIService method
        APIService.shared.registerUserWithImage(
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email,
            password: password,
            image: image
        ) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.registrationSuccess = true
                    self.errorMessage = nil
                    // Optionally navigate to Login
                    self.onLogin()
                case .failure(let error):
                    self.registrationSuccess = false
                    self.errorMessage = "Registration failed: \(error.localizedDescription)"
                }
            }
        }
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
