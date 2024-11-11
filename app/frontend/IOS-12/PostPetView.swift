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
    @State private var losingDate = Date()
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
                        
                        DatePicker("Birthday", selection: $losingDate, in: ...Date(), displayedComponents: .date)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    // Description Section
                    Section(header: Text("Description")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) { // Braun für Überschrift
                        TextEditor(text: $description)
                            .padding()
                            .frame(height: 100)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    // Photo Section
                    Section(header: Text("Pet Photo")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) { // Braun für Überschrift
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(white: 0.9)) // Light brown color
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
                    
                    // Submit Button
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
                .background(Color(hex: "#FFE3C4")) // Set the background color here
                .navigationTitle("Post Pet")
            
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                        
                }
            }
            .background(Color(hex: "#FFE3C4")) // Set the background color for the whole screen
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        picture = Image(uiImage: inputImage)
    }
}

struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}



