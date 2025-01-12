//
//  PetDetailView.swift
//  IOS-12
//
//  Created by Feyza Serin on 07.11.24.
//

import SwiftUI
import MapKit
import CoreLocation

struct PetDetailView: View {
    
    @State private var userCoordinate: CLLocationCoordinate2D? = nil
    @State private var destinationCoordinate: CLLocationCoordinate2D? = nil

    
    private func setUserLocation() {
        if let location = CLLocationManager().location?.coordinate {
            userCoordinate = location
        }
    }

    private func setDestination(latitude: Double, longitude: Double) {
        destinationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    @State var isFavorite: Bool = false
    @State var currentIndex: Int = 0

    @State private var isFullScreen: Bool = false
    @State private var selectedImage: String = ""

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.3704, longitude: 6.1724),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var userLocation: String = ""
    @State private var distance: String? = nil

    let pet: Pet

    private var trailingView: some View {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
            .foregroundColor(.red)
            .frame(width: 36, height: 36)
            .background(Color.white)
            .cornerRadius(18)
            .onTapGesture {
                isFavorite.toggle()
            }
    }

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ZStack(alignment: Alignment.bottom) {
                    // Image Carousel with Tap to View Full-Screen
                    TabView(selection: $currentIndex) {
                        ForEach(0..<pet.images.count, id: \ .self) { index in
                            Image(pet.images[index])
                                .resizable()
                                .scaledToFill()
                                .onTapGesture {
                                    selectedImage = pet.images[index]
                                    isFullScreen = true
                                }
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 355)
                }
                .frame(height: 355, alignment: .center)
                
                // Pet Details Section
                HStack(spacing: 20) {
                    BoxDetailView(title: "Birthday", description: "\(pet.birthday) Months")
                    
                    BoxDetailView(title: "Fee", description: String(format: "%.1f", pet.fee))
                    BoxDetailView(title: "Sex", description: pet.gender.rawValue.capitalized)
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(pet.name)
                            .font(.system(size: 18, weight: .medium))
                        Spacer()
                        Text(pet.breed.name)
                            .font(.system(size: 18, weight: .regular))
                    }
                    .padding(.top)
                    
                    HStack {
                        Image("location")
                        Text("Phnom Penh, Cambodia")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.top, 5)
                    
                    Text("About")
                        .font(.system(size: 18, weight: .medium))
                        .padding(.top, 10)
                    
                    Text(pet.description)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                }
                .foregroundColor(.darkText)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Map and Location Input Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Location")
                        .font(.system(size: 18, weight: .medium))
                        .padding(.bottom, 5)

                    MapView(userCoordinate: $userCoordinate, destinationCoordinate: <#Binding<CLLocationCoordinate2D?>#>)
                        .frame(height: 200)
                        .cornerRadius(15)

                    Button("Pet Location") {
                        setUserLocation()
                    }
                    .padding()

                    Button("My Address") {
                        setDestination(latitude: 51.3704, longitude: 6.1724) // Beispielkoordinaten
                    }
                    .padding()
                }
                .padding()

                                .padding()
                            }


            HStack {
                Button(action: {}) {
                    HStack {
                        Image("paw")
                        Text("Adopt")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.primaryColor)
                    .cornerRadius(15)
                }

                Button(action: {}) {
                    Image(systemName: "phone.fill")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color.primaryLight)
                        .cornerRadius(15)
                }
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: trailingView)
       /* .fullScreenCover(isPresented: $isFullScreen) {
            FullScreenImageView(imageName: selectedImage, isPresented: $isFullScreen)
        }*/
    }

    private func calculateDistance() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(userLocation) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                distance = "Invalid location"
                return
            }

            let petLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
            let distanceInMeters = location.distance(from: petLocation)
            distance = String(format: "%.2f km", distanceInMeters / 1000)
        }
    }
}

struct BoxDetailView: View {
    let title: String
    let description: String

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 14, weight: .regular))
            Text(description)
                .font(.system(size: 16, weight: .medium))
        }
        .padding(10)
        .foregroundColor(.black)
        .frame(width: 100, height: 65, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray))
    }
}

struct PetDetailPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if let pet = PetData.dogs.first {
                PetDetailView(pet: pet)
            } else {
                Text("No pets available")
            }
        }
    }
}
