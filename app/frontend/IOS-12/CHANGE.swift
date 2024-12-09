//
//  CHANGE.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.12.24.
//

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
    @State private var fee = ""
    @State private var gender = true // true = Male, false = Female
    @State private var petType = ""
    @State private var showPicker = false
    let petTypes = ["Dog", "Cat", "Bird", "Fish", "Other"]
    @State private var breed = ""
    @State private var birthday = Date()

    @State private var description = ""
    @State private var location = ""
    
    // Image handling
    @State private var picture: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    // Photo and name section
                    Section(header: Text("Photo")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
                            
                            HStack(alignment: .top, spacing: 40) {
                                ZStack {
                                    Circle()
                                        .fill(Color(white: 0.9))
                                        .frame(width: 130, height: 130)
                                    
                                    if let picture = picture {
                                        picture
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 130, height: 130)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    } else {
                                        Text("+")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .onTapGesture {
                                                showingImagePicker = true
                                            }
                                    }
                                }
                                
                                // Pet Name and Fee Fields
                                VStack(alignment: .leading, spacing: 15) {
                                    TextField("Pet Name", text: $petName)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .frame(width: 200)
                                    
                                    TextField("Fee", text: $fee)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .frame(width: 200) // Match width to the pet name field
                                }
                            }
                            .padding(.top, 10) // Add spacing at the top
                            
                            
                            
                        }
                                
                               
                    
                    
                    
            
                    
                    // Pet Details Section
                    Section(header: Text("Pet Information")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) { // Braun für Überschrift
                            
                            Picker("Gender", selection: $gender) {
                                Text("Male").tag(true)
                                Text("Female").tag(false)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom, 10)
                            
                            
                            // Dropdown menu for pet type
                            Menu{
                                ForEach(petTypes, id: \.self) { type in
                                    Button(action: {
                                        petType = type
                                    }) {
                                        Text(type)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("Pet Type:")
                                    Text(petTypes.isEmpty ? "Select a type" : petType)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .frame(width: 370)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                            
                            
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
                    
                    
                    Section(header: Text("Location")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
                            TextField("Location", text: $location)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
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



struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}



