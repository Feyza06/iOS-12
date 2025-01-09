//
//  MapView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 9.01.25.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapView: UIViewRepresentable {
    
    @Binding var userCoordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView{
        let mapView = MKMapView(frame: .zero)
        mapView.layer.cornerRadius = 20
        mapView.clipsToBounds = true
        mapView.showsUserLocation = true
        return mapView
       
    }
    
    func updateUIView(_ view: MKMapView, context: Context){
        if let coordinate = userCoordinate {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "You are here"
                    view.addAnnotation(annotation)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    view.setRegion(region, animated: true)
                }
    }
}

struct MapViewContainer: View {
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
       
        VStack {
            Text("Address")
                .font(.headline)
                .padding()
          
                      HStack {
                          TextField("Enter Address", text: $locationManager.enteredAddress)
                              .padding()
                              .background(Color.white)
                              .cornerRadius(8)
                              .shadow(radius: 2)
                          
                          Button(action: {
                              locationManager.geocodeAddress() // Geocode and update map
                          }) {
                              Image(systemName: "magnifyingglass")
                                     .padding()
                                     .background(Color.orange)
                                     .foregroundColor(.white)
                                     .cornerRadius(8)
                          }
                      }
                      .padding()
            
            MapView(userCoordinate: $locationManager.userLocation)
                .frame(width: 400, height: 200)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
                .border(Color.gray, width: 1)
            
            Spacer()
        }
        .padding()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var enteredAddress: String = ""
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func geocodeAddress() {
        guard !enteredAddress.isEmpty else { return }
        
        geocoder.geocodeAddressString(enteredAddress) { [weak self] placemarks, error in
            guard let self = self, error == nil, let location = placemarks?.first?.location else {
                DispatchQueue.main.async {
                    self?.userLocation = nil
                }
                return
            }
            
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
            }
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapViewContainer()
    }
}
