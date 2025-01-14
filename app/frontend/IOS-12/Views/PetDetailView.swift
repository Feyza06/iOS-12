//
//  PetDetailView.swift
//  IOS-12
//
//  Created by Feyza Serin on 07.11.24.
//

import SwiftUI
import CoreLocation

struct PetDetailView: View {
    @State var isFavorite: Bool = false
    @State private var selectedImage: String = ""
    @State private var showDistanceView: Bool = false

    @EnvironmentObject var appState: AppState
    let post: PostResponse

    private var trailingView: some View {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
            .foregroundColor(.primaryColor)
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
                ZStack {
                    if let photoPath = post.photo,
                       let imageUrl = URL(string: "http://127.0.0.1:3000" + photoPath),
                       post.hasPhoto {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 280, height: 280)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 280, height: 280)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            case .failure:
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 280, height: 280)
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 70)
                                        .foregroundColor(.white)
                                }
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 280, height: 280)
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 70)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(width: 300, height: 300)
                .padding(.top, 55)

                HStack(spacing: 20) {
                    BoxDetailView(icon: "creditcard", description: String(format: "€%.2f", post.fee))
                    BoxDetailView(icon: "calendar", description: post.birthday)
                    BoxDetailView(icon: "pawprint", description: post.gender)
                }
                .padding(.top, 10)

                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 80) {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.system(size: 23, weight: .bold))
                                .foregroundColor(.primaryColor)
                            Text(post.petName)
                        }

                        VStack(alignment: .leading) {
                            Text("Breed")
                                .font(.system(size: 23, weight: .bold))
                                .foregroundColor(.primaryColor)
                            Text(post.petBreed)
                        }
                    }

                    Text("Description")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.primaryColor)
                    Text(post.description)

                    Text("Address")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.primaryColor)
                    Text(post.location)

                    Button(action: {
                        showDistanceView = true
                        print("Location passed to DistanceView: \(post.location)")
                    }) {
                        HStack {
                            Image(systemName: "location.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primaryColor)

                            Text("Route")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primaryColor)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                    .sheet(isPresented: $showDistanceView) {
                        DistanceView(fixedLocation: CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)) // Düsseldorf
                            .environmentObject(AppState())
                    }
                }
                .foregroundColor(.darkText)
                .padding()
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: trailingView)
        }
    }
}

// Definition von BoxDetailView
struct BoxDetailView: View {
    let icon: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: icon) // SF Symbol für das Icon
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 24)
                .foregroundColor(.darkText)
            Text(description)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(10)
        .foregroundColor(.darkText)
        .frame(width: 100, height: 65, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey))
    }
}

// Vorschau
struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePost = PostResponse(
            id: 1,
            petName: "Buddy",
            fee: 20.0,
            gender: "Male",
            petType: "Dog",
            petBreed: "Golden Retriever",
            birthday: "2020-01-01",
            description: "Buddy is a friendly and playful Golden Retriever looking for a loving home.",
            location: "Düsseldorf, Germany",
            hasPhoto: true,
            photo: "/uploads/sample.jpg",
            status: "Available",
            createdAt: "2023-01-01",
            userId: "123"
        )

        NavigationView {
            PetDetailView(post: samplePost)
                .environmentObject(AppState())
        }
    }
}
