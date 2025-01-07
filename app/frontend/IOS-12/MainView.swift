//
//  MainView.swift
//  IOS-12
//
//  Created by Feyza Serin on 07.11.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var searchText: String = ""
    @State private var locationSearchText: String = "Düsseldorf"
    @State private var selectedSpecies: Species = .dog
    @State private var selectedTab: CustomTabBar.Tab = .home
    
    // Existing state for PostPetView
    @State private var showPostPetView: Bool = false
    
    // New state for MessagesView
    @State private var showConversationsView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .regular))
                    .padding()
                Image(systemName: "magnifyingglass")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(Color.primaryColor)
                    .cornerRadius(10)
            }
            .frame(height: 40)
            .background(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.lightGrey, lineWidth: 1))
            .padding()
            
            PetTypeView(selectedSpecies: $selectedSpecies)

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(selectedSpecies.pets) { pet in
                        PetView(pet: pet)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            
            // Pass the new Binding to the CustomTabBar
            CustomTabBar(
                selectedTab: $selectedTab,
                showPostPetView: $showPostPetView,
                showConversationsView: $showConversationsView
            )
        }
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            leading: locationSearchBar,
            trailing: HStack(spacing: 16) {
                profileView
                logoutButton
            }
        )
        // Present the PostPetView
        .fullScreenCover(isPresented: $showPostPetView) {
            PostPetView()
        }
        // Present the new MessagesView
        .fullScreenCover(isPresented: $showConversationsView) {
            ConversationsView()
        }
    }
}

extension MainView {
    var profileView: some View {
        Image("profile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 36, height: 36)
            .clipShape(Circle())
    }

    var logoutButton: some View {
        Button(action: {
            // Logout action
            appState.isLoggedIn = false
            // Optionally, delete the auth token from the Keychain
            KeychainHelper.standard.delete(service: KeychainKeys.service, account: KeychainKeys.authToken)
        }) {
            Image(systemName: "power")
                .foregroundColor(.red)
        }
    }

    var locationSearchBar: some View {
        HStack {
            Image("location")
                .foregroundColor(.primaryColor)
            TextField("Search for Location", text: $locationSearchText)
                .foregroundColor(.darkText)
            Button(action: {
                locationSearchText = ""
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.darkText)
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 36)
        .background(Color.primaryLight)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
}

private extension Species {
    var pets: [Pet] {
        switch self {
        case .dog:
            return PetData.dogs
        case .cat:
            return PetData.cats
        // Add cases for other species as needed
        default:
            return []
        }
    }
}

struct PetTypeView: View {
    
    @Binding var selectedSpecies: Species
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Species.allCases) { species in
                    Button(action: {
                        selectedSpecies = species
                    }) {
                        VStack {
                            Image(species.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 64, height: 64)
                                .foregroundColor(selectedSpecies == species ? .secondaryDark : .darkText)
                                .background(selectedSpecies == species ? Color.secondaryColor : .clear)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey, lineWidth: 1))
                            Text(species.id.capitalized)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.darkText)
                        }
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
}

struct PetView: View {
    
    let pet: Pet
    
    @State var isFavorite: Bool = false
    
    var body: some View {
        NavigationLink(
            destination: PetDetailView(pet: pet)) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    if let firstImage = pet.images.first {
                        Image(firstImage)
                            .resizable()
                            .frame(height: 160)
                            .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .topRight]))
                    } else {
                        Image("defaultImage")
                            .resizable()
                            .frame(height: 160)
                    }
                    Button(action: {
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.primaryColor)
                            .frame(width: 32, height: 32)
                            .background(Color.white)
                            .clipShape(Circle())
                            .padding(10)
                    }
                }
                HStack {
                    Text(pet.displayType)
                        .frame(width: 70, height: 22)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(pet.isAdult ? .primaryYellow : .primaryColor)
                        .background(pet.isAdult ? Color.secondaryYellow : Color.primaryLight)
                        .cornerRadius(10)
                    Spacer()
                    Image(pet.gender.rawValue)
                        .foregroundColor(pet.isAdult ? Color.primaryYellow : Color.primaryColor)
                }
                .padding(.leading)
                .padding(.trailing)
                
                VStack(spacing: 4) {
                    Text(pet.name)
                        .font(.system(size: 18, weight: .medium))
                    Text(pet.breed.name)
                        .font(.system(size: 14, weight: .regular))
                }
                .foregroundColor(.darkText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.bottom, 10)
            }
                
            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey, lineWidth: 1))
            .padding(.leading)
            .padding(.trailing)
        }
    }
}

extension Color {
    static let primaryColor = Color(hex: "#5B220D") ?? .black
    static let primaryLight = Color(hex: "#FFB977") ?? .orange
    static let darkText = Color.black
    static let lightGrey = Color.gray
    static let secondaryColor = Color.orange
    static let secondaryDark = Color.brown
    static let primaryYellow = Color.yellow
    static let secondaryYellow = Color.orange
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
                .environmentObject(AppState())
        }
    }
}
