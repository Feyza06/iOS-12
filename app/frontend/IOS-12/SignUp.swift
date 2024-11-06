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
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
<<<<<<< Updated upstream
    @State private var registrationSuccess = false
    @State private var showErrorLabel = false
    @State private var errorMessage:String?
=======
    @State private var errorMessage: String?
    @State private var registrationSuccess: Bool = false
>>>>>>> Stashed changes
    
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
                    
<<<<<<< Updated upstream
                    TextField("Username", text: $username)
=======
                    TextField("Mobile", text: $username)
>>>>>>> Stashed changes
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
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Sign Up") {
                        if email.isEmpty || firstname.isEmpty || lastName.isEmpty || username.isEmpty || password.isEmpty {
<<<<<<< Updated upstream
                            //showErrorLabel = true
                            errorMessage = "Please fill out all fields correctly."
                            
                        } else {
                            //howErrorLabel = false
                            registerUser()
                            // Registrierung erfolgreich
=======
                            errorMessage = "Please fill out all fields correctly!"
                        } else {
                            registerUser()
>>>>>>> Stashed changes
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .cornerRadius(10)
                    
<<<<<<< Updated upstream
                  
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .bold()
                    }else if registrationSuccess {
                        Text("Registartion successful!")
                            .foregroundColor(.green)
                            .padding()
                            .bold()
                    }
                    
                    // Link zur Login-Ansicht
=======
>>>>>>> Stashed changes
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
    
<<<<<<< Updated upstream
    private func registerUser() {
           let userData: [String: Any] = [
               "firstname": firstname,
               "lastname": lastName,
               "username": username,
               "email": email,
               "password": password
           ]
           
           guard let url = URL(string: "http://127.0.0.1:3000/users") else {
               errorMessage = "Invalid URL"
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
           } catch {
               errorMessage = "Error serializing JSON: \(error.localizedDescription)"
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
                              errorMessage = "Invalid response."
                          }
                          return
                      }
               
               if let httpResponse = response as? HTTPURLResponse{
                   
                   print("HTTP Status Code: \(httpResponse.statusCode)")
                              if let data = data, let responseString = String(data: data, encoding: .utf8) {
                                  print("Response Data: \(responseString)")
                              }
                   
                   DispatchQueue.main.async {
                       if httpResponse.statusCode == 200 {
                                  registrationSuccess = true
                                  errorMessage = nil
                              } else {
                                  errorMessage = "Registration failed. Server responded with status code: \(httpResponse.statusCode)"
                              }
                   }
               } else {
                   DispatchQueue.main.async {
                       errorMessage = "Registration failed. Please try again."
                   }
               }
           }.resume()
       }
    }



=======
    func registerUser() {
        let userData: [String: Any] = [
            "firstname": firstname,
            "lastname": lastName,
            "username": username,
            "email": email,
            "password": password
        ]
        
        guard let url = URL(string: "https://localhost:3000/users") else {
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
        } catch {
            errorMessage = "Error serializing JSON: \(error.localizedDescription)"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received."
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    registrationSuccess = true
                    errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    errorMessage = "Registration failed. Please try again."
                }
            }
        }.resume()
    }
}
>>>>>>> Stashed changes

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

