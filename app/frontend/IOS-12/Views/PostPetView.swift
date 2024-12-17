//
//  PostPetView.swift
//  IOS-12
//
//  Created by Feyza Serin on 11.11.24.
//

import SwiftUI
import MapKit
import CoreLocation

struct PostPetView: View {

    
    @StateObject private var appState = AppState()
    

    // Pet details
    @State private var petName = ""
    @State private var gender = true // true = Male, false = Female
    @State private var fee = ""
    let petTypes = ["Dog", "Cat", "Bird", "Fish", "Other"]
    @State private var selectedPetType = ""
    @State private var breed = ""
    @State private var birthday = Date()
    
    // Image handling
    @State private var picture: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
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
    
    // View Model
    @ObservedObject private var viewModel = PostViewModel()
    
    
    // Message
    @State private var statusMessage: String?
    @State private var isSuccess: Bool?
    
//    
//      init(viewModel: PostViewModel) {
//          _viewModel = ObservedObject(wrappedValue: viewModel)
//      }
    
    
    var body: some View {
        NavigationView {

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
                    
                    // Map Section
                    Section(header: Text("Enter Address")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
                            VStack {
                                TextField("Enter address", text: $addressString)

            ZStack {
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
                            birthday: $birthday
                        )
                        
                        // Description Section
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
                        
                        // Pet Photo Section
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
                        
                        // Map Section
                        Section(header: Text("Enter Address")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
                                VStack {
                                    TextField("Enter address", text: $addressString)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .onChange(of: addressString) { newValue in
                                            lookupAddress(for: newValue)
                                        }
                                    
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
                                    
                                    Button(action: {
                                        print("Selected location: \(selectedCoordinate), Address: \(addressString)")
                                    }) {
                                        Text("Set Location")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 8)
                                            .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                    }
                                    .padding(.top, 10)
                                }
                            }
                        
                        // Post Button
                        Button(action: validateFields) {
                            Text("Post")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
      
                    // Post Button
                    Button(action: {
                        
                        // trigger the upload
                        let postRequest = PostRequest (petName: petName, fee: Double(fee) ?? 0.0, gender: gender ? "Male" : "Female", petType: selectedPetType, petBreed: breed, birthday: birthday, description: description, location: addressString, photo: (inputImage != nil))
                        
                        viewModel.uploadPost(postRequest: postRequest) { result in
                            switch result {
                            case .success(let response):
                                statusMessage = "Post uploaded successfully!"
                                isSuccess = true
                            case .failure(let error):
                                statusMessage = "Failed to upload post: \(error.localizedDescription)"
                                isSuccess  = false
                            }}
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
                    .padding(.top, 20)
                    
                    if let statusMessage = statusMessage {
                        Text(statusMessage)
                            .fontWeight(.bold)
                            .foregroundColor(isSuccess == true ? .green : .red)
                            .padding()
                    }
                }
                .padding()
                .background(Color(hex: "#FFE3C4"))
                .navigationTitle("Post Pet")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)

                        .padding(.top, 20)
                    }
                    
                    .padding()
                    

                }
                            .background(Color(hex: "#FFE3C4"))
                            .navigationTitle("Post Pet")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(leading: Button(action: {
                                dismiss() // Zurück zur vorherigen View
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left") // Pfeil-Symbol
                                        .foregroundColor(.blue)
                                    Text("Back")
                                        .foregroundColor(.blue)
                                }
                            })
                            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                                ImagePicker(image: $inputImage)
                            }
                // Error Overlay
                ErrorOverlay(isVisible: $showError, message: errorMessage)
            }
        }
    }
    
    func validateFields() {
        if fee.isEmpty {
            errorMessage = "Please enter a valid fee."
            withAnimation {
                showError = true
            }
        }
    }
    
    // MARK: - Helper functions
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        picture = Image(uiImage: inputImage)
    }
    
    func lookupAddress(for address: String) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
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







//    
//struct PostPetView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostPetView(viewModel: MockPostViewModel())
//    }
//}
//
//


    
struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}


