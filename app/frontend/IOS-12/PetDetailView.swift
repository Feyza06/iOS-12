//
//  PetDetailView.swift
//  IOS-12
//
//  Created by Feyza Serin on 07.11.24.
//

import SwiftUI

struct PetDetailView: View {
    
    @State var isFavorite: Bool = false
    @State var currentIndex: Int = 0
    
    @State private var isFullScreen: Bool = false
    @State private var selectedImage: String = ""
    @State private var showToast: Bool = false // Toast-Status hinzufügen

    
    @ObservedObject var favoritesViewModel = FavoritesViewModel()

    
   
    let pet: Pet
    
    init(pet: Pet, favoritesViewModel: FavoritesViewModel = FavoritesViewModel()) {
            self.pet = pet
            self.favoritesViewModel = favoritesViewModel
            _isFavorite = State(initialValue: favoritesViewModel.isFavorite(pet.id.uuidString))
        }
    
    
    private func toggleFavorite() {
        print("ToggleFavorite tapped. Current isFavorite: \(isFavorite)") // Debug-Ausgabe
        if isFavorite {
            favoritesViewModel.removeFavorite(withId: pet.id.uuidString) { result in
                if case .success = result {
                    isFavorite = false
                    showToast = true
                    print("Removed from favorites") // Debug-Ausgabe
                } else {
                    print("Failed to remove from favorites") // Fehlerausgabe
                }
            }
        } else {
            
            let favorite = Favourite(id: pet.id.uuidString, name: pet.name, type: pet.species.rawValue)
            favoritesViewModel.addFavorite(favorite) { result in
                if case .success = result {
                    isFavorite = true
                    showToast = true
                    print("Added to favorites") // Debug-Ausgabe
                } else {
                    print("Failed to add to favorites") // Fehlerausgabe
                }
            }
        }
    }

    
    private var trailingView: some View {
        Button(action: {
            toggleFavorite()
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.primaryColor)
                .frame(width: 36, height: 36)
                .background(Color.white)
                .cornerRadius(18)
        }
    }

    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ZStack(alignment: Alignment.bottom) {
                    // Image Carousel with Tap to View Full-Screen
                    TabView(selection: $currentIndex) {
                        ForEach(0..<pet.images.count, id: \.self) { index in
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
                    BoxDetailView(title: "Age", description: "\(pet.age) Months")
                    BoxDetailView(title: "Weight", description: String(format: "%.1f kg", pet.weight))
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
        .fullScreenCover(isPresented: $isFullScreen) {
            FullScreenImageView(imageName: selectedImage, isPresented: $isFullScreen)
        }
        .toast(isPresented: $showToast, message: isFavorite ? "Removed from Favorites" : "Added to Favorites")

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
        .foregroundColor(.darkText)
        .frame(width: 100, height: 65, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey))
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




