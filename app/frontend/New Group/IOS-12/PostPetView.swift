//
//  PostPetView.swift
//  IOS-12
//
//  Created by Feyza Serin on 11.11.24.
//

import SwiftUI
import CoreLocation
import Photos

struct PostPetView: View {
    // Pet details
    @State private var petName = ""
    @State private var petType = ""
    @State private var breed = ""
    @State private var gender = true // true = Male, false = Female
    @State private var description = ""
    
    // Lost details
    @State private var birthday = Date()
    @State private var location = ""
    
    // Image handling
    @State private var picture: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // Pet Details Section
                    Section(header: Text("Pet Information")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) { // Braun für Überschrift
                        TextField("Pet Name", text: $petName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Picker("Gender", selection: $gender) {
                            Text("Male").tag(true)
                            Text("Female").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 10)
                        
                        TextField("Type", text: $petType)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        TextField("Breed", text: $breed)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    
                    Section(header: Text("Description")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
                        TextEditor(text: $description)
                            .padding()
                            .frame(height: 100)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    
                    Section(header: Text("Pet Photo")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(white: 0.9))
                                .frame(height: 200)
                            if let picture = picture {
                                picture
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            } else {
                                Text("Upload a picture")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        showingImagePicker = true
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    
                    Button(action: {
                        // Submit action goes here
                    }) {
                        Text("Post")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.55, green: 0.27, blue: 0.07)) // Braun für Button
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                }
                .padding()
                .background(Color(hex: "#FFE3C4")) 
                .navigationTitle("Post Pet")
            
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                        
                }
            }
            .background(Color(hex: "#FFE3C4")) 
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        picture = Image(uiImage: inputImage)
    }
}

/*private func registerUser() {
    let postData: [String: Any] = [
        "petName": petName,
        "petType": petType,
        "breed": breed,
        "gender": gender,
        "description": description
    ]

    guard let url = URL(string: "http://127.0.0.1:3000/posts") else {
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

        DispatchQueue.main.async {
            if httpResponse.statusCode == 200 {
                registrationSuccess = true
                errorMessage = nil
                email = ""
                firstname = ""
                lastName = ""
                username = ""
                password = ""
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
*/

struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}



