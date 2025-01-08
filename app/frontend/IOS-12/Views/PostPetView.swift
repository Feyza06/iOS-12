//
//  PostPetView.swift
//  IOS-12
//
//  Created by Feyza Serin on 11.11.24.
//

// PostPetView.swift

import SwiftUI
import MapKit
import CoreLocation



struct PostPetView: View {
    @StateObject private var appState = AppState()
    
    // Pet details
    @State private var petName = ""
    @State private var gender = true // true = Male, false = Female
    @State private var fee = ""
    @State private var feeValue: Double = 0.0
    let petTypes = ["Dog", "Cat", "Bird", "Fish", "Other"]
    @State private var selectedPetType = ""
    @State private var breed = ""
    @State private var birthday = Date()
    
    // Image handling
    @State private var picture: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var showingImageSourceActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
    // Map handling
    @State private var addressString = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.3704, longitude: 6.1724),
        span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
    )
    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 51.3704, longitude: 6.1724)
    @State private var description = ""
    
    // Error handling
    @State private var showError = false
    @State private var errorMessage = "Something went wrong"
    
    @Environment(\.dismiss) var dismiss
    
    private let geocoder = CLGeocoder()
   
    
    // Message
    @State private var statusMessage: String?
    @State private var isSuccess: Bool?
    
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        // Pet Information Section
                        PetInformationView(
                            petName: $petName,
                            gender: $gender,
                            fee: $fee,
                            petTypes: petTypes,
                            selectedPetType: $selectedPetType,
                            breed: $breed,
                            birthday: $birthday,
                            description: $description
                        )
                        
                        // Pet Photo Section
                        Section(header: Text("Pet Photo").font(.headline)) {
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
                                            //showingImagePicker = true
                                            showingImageSourceActionSheet = true // Correct
                                        }
                                }
                            }
                            .padding()
                        }
                        .confirmationDialog("Select Image Source", isPresented: $showingImageSourceActionSheet){
                            Button("Take a photo"){
                                imageSource = .camera
                                showingImagePicker = true
                            }
                            Button("Choose from Library") {
                                imageSource = .photoLibrary
                                showingImagePicker = true
                            }
                            Button("Cancel", role: .cancel) {}
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage ){
                            ImagePicker(image: $inputImage, sourceType: imageSource)
                        }
                        
                        
                        // Map Section
                        Section(header: Text("Enter Address").font(.headline)) {
                            VStack {
                                TextField("Enter address", text: $addressString)
                                    .onChange(of: addressString) { newValue in
                                        lookupAddress(for: newValue)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                ZStack {
                                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                                        .frame(height: 300)
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                        .offset(y: -15)
                                }
                            }
                        }
                        
                        // Post Button
                        Button(action: {
                            
                            validateFields()
                            if !isSuccess! {
                                // Show error message and don't proceed
                                //self.statusMessage = "Missing fields!"
                                return
                            }
                            
                            viewModel.uploadPost(
                                postRequest: PostRequest(
                                    petName: petName,
                                    fee: Double(fee) ?? 0.0,
                                    gender: gender ? "Male" : "Female",
                                    petType: selectedPetType,
                                    petBreed: breed,
                                    birthday: birthday,
                                    description: description,
                                    location: addressString,
                                    hasPhoto: inputImage != nil
                                ),
                                photo: inputImage
                                
                            ){ result in
                                switch result {
                                case .success:
                                    self.statusMessage = "Post uploaded successfully!"
                                    self.isSuccess = true
                                    print("Post uploaded successfully.")
                                case .failure(let error):
                                    self.statusMessage = "Failed to upload post: \(error.localizedDescription)"
                                    self.isSuccess = false
                                    print("Failed to upload post: \(error.localizedDescription)")
                                }
                                
                            }
                        }) {
                            Text("Post")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        
                        
                        // Display status message at the top center of the screen
                        
                    }
                    .padding()
                }
                .navigationTitle("Post Pet")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }
            }
            //        .errorOverlay(isVisible: $showError, message: errorMessage)
        }
        
        
    }
    
    
    
    // Helper functions
    func validateFields() {
        if petName.isEmpty || fee.isEmpty || description.isEmpty || selectedPetType.isEmpty {
                    statusMessage = "All fields must be filled!"
                    isSuccess = false
                } else {
                    isSuccess = true // Valid fields
                }
        
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        picture = Image(uiImage: inputImage)
    }
    
    func lookupAddress(for address: String) {
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding failed: \(error)")
                self.addressString = "Unknown"
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                self.selectedCoordinate = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude: 51.3704, longitude: 6.1724)
                self.region.center = self.selectedCoordinate
                self.addressString = [placemark.thoroughfare, placemark.subThoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
        }
    }
}

struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}
