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

    // Map handling
    @State private var addressString = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.3704, longitude: 6.1724),
        span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
    )
    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 51.3704, longitude: 6.1724)
    
    private let geocoder = CLGeocoder()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // Pet Details Section
                    Section(header: Text("Pet Information")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
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
                                location = addressString
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
                            .frame(height: 40) // Making the button thinner
                        }
                    }
                    
                    Button(action: {
                        // Submit action goes here
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

struct VenloAnnotation: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
}

struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}


