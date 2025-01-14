//
//  DistanceView.swift
//  IOS-12
//
//  Created by Feyza Serin on 14.01.25.
//

import SwiftUI
import MapKit
import CoreLocation

struct DistanceView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var route: MKRoute?
    @State private var searchText = ""

    var fixedLocation: CLLocationCoordinate2D
    @State private var searchLocation: CLLocationCoordinate2D?
    @State private var mapRegion: MKCoordinateRegion

    init(fixedLocation: CLLocationCoordinate2D) {
        self.fixedLocation = fixedLocation
        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: fixedLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
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

            // Karte mit Markierungen und Route
            Map(coordinateRegion: $mapRegion, annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    Circle()
                        .fill(annotation.isFixed ? Color.black : Color.blue)
                        .frame(width: 10, height: 10)
                }
            }
            .overlay(route != nil ? MapPolyline(route: route!) : nil)
            .onAppear {
                locationManager.requestLocation()
            }

            Spacer()
        }
    }

    private var annotations: [AnnotationItem] {
        var items = [AnnotationItem(coordinate: fixedLocation, isFixed: true)]
        if let searchLocation = searchLocation {
            items.append(AnnotationItem(coordinate: searchLocation, isFixed: false))
        }
        return items
    }

    private func searchForLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { placemarks, error in
            if let error = error {
                print("Error searching location: \(error.localizedDescription)")
                return
            }
            if let coordinate = placemarks?.first?.location?.coordinate {
                self.searchLocation = coordinate
                self.mapRegion.center = coordinate
                calculateRoute(to: coordinate)
            }
        }
    }

    private func calculateRoute(to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: fixedLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error calculating route: \(error.localizedDescription)")
            } else if let route = response?.routes.first {
                self.route = route
            }
        }
    }
}

// Annotation-Helper
struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let isFixed: Bool
}

// Routen-Overlay
struct MapPolyline: UIViewRepresentable {
    let route: MKRoute

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
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



func calculateRoute(from start: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, mapView: MKMapView) {
    let source = MKPlacemark(coordinate: start)
    let destination = MKPlacemark(coordinate: destination)

    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: source)
    request.destination = MKMapItem(placemark: destination)
    request.transportType = .automobile // Oder .walking

    let directions = MKDirections(request: request)
    directions.calculate { (response, error) in
        if let error = error {
            print("Route calculation failed: \(error.localizedDescription)")
            return
        }

        if let route = response?.routes.first {
            mapView.addOverlay(route.polyline) // Füge die Route hinzu
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString("Düsseldorf") { (placemarks, error) in
        if let error = error {
            print("Geocoding failed: \(error.localizedDescription)")
            return
        }

        if let location = placemarks?.first?.location {
            let coordinate = location.coordinate
            print("Geocoded location: \(coordinate)")
            // Bewege die Karte hierhin
        }
    }

}


struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceView(fixedLocation: CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735))
    }
}
