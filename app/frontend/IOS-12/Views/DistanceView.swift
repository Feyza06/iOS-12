//
//  DistanceView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 11.01.25.
//

import SwiftUI
import MapKit
import CoreLocation

struct DistanceView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var route: MKRoute?
    @State private var searchText = ""

    var petName: String
    var petType: String
    var location: String

    @State private var destinationCoordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Environment(\.presentationMode) var presentationMode

    init(petName: String, petType: String, location: String) {
        self.petName = petName
        self.petType = petType
        self.location = location
        if let coordinates = convertStringToCoordinates(location) {
            _destinationCoordinates = State(initialValue: coordinates)
        }
    }

    var body: some View {
        VStack {
            // Suchfeld
            HStack {
                TextField("Search location", text: $searchText, onCommit: {
                    searchForLocation()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

                Button(action: {
                    searchForLocation()
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            .padding(.top)

            // Karte mit Route-Overlay
            Map(
                coordinateRegion: .constant(MKCoordinateRegion(
                    center: locationManager.currentLocation?.coordinate ?? destinationCoordinates,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )),
                showsUserLocation: true,
                annotationItems: [
                    LocationAnnotation(coordinate: destinationCoordinates)
                ]
            ) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    VStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .overlay(
                // Hier wird die Route gezeichnet
                route != nil ? MapPolyline(route: route!) : nil
            )
            .onAppear {
                locationManager.requestLocation()
                fetchRoute()
            }

            Spacer()
        }
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.blue)
                .padding(6)
                .background(Color.clear)
                .cornerRadius(10)
        })
        .navigationBarTitleDisplayMode(.inline)
    }

    private func searchForLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { placemarks, error in
            if let error = error {
                print("Error searching location: \(error.localizedDescription)")
                return
            }
            if let coordinate = placemarks?.first?.location?.coordinate {
                destinationCoordinates = coordinate
                fetchRoute()
            }
        }
    }

    private func fetchRoute() {
        guard let userLocation = locationManager.currentLocation else {
            print("User location not available")
            return
        }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinates))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error fetching directions: \(error.localizedDescription)")
            } else if let route = response?.routes.first {
                self.route = route
            }
        }
    }

    private func convertStringToCoordinates(_ locationString: String) -> CLLocationCoordinate2D? {
        let components = locationString.components(separatedBy: ",")
        guard components.count == 2,
              let latitude = Double(components[0]),
              let longitude = Double(components[1]) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// Helper struct for Annotation
struct LocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

// Helper für Routen-Overlay
struct MapPolyline: UIViewRepresentable {
    let route: MKRoute

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        uiView.addOverlay(route.polyline)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapPolyline

        init(_ parent: MapPolyline) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

struct MapPolylineOverlay: Shape {
    let route: MKRoute

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let points = route.polyline.points()
        let pointCount = route.polyline.pointCount

        guard pointCount > 1 else { return path }

        path.move(to: CGPoint(x: points[0].coordinate.latitude, y: points[0].coordinate.longitude))
        for i in 1..<pointCount {
            path.addLine(to: CGPoint(x: points[i].coordinate.latitude, y: points[i].coordinate.longitude))
        }
        return path
    }
}

struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceView(
            petName: "Buddy",
            petType: "Dog",
            location: "37.7749,-122.4194" // San Francisco
        )
    }
}
