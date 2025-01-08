//
//  MainView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 08.01.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    // View Model
    @StateObject private var postViewModel = PostViewModel()
    
    @State private var selectedTab: CustomTabBar.Tab = .home
    @State private var selectedPetType: String = "Dogs"
    
    @State private var showPostPetView: Bool = false
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Image(systemName: "house.fill") // House icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.primaryColor)
                
                Text("Pet Adoption")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primaryColor)
                    .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 16)
            .padding(.bottom, 10)
            
            
            // Scrollable row
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    Text("All")
                        .underline()
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    
                    // Pet type buttons
                    ForEach(["Dogs", "Cats", "Rabbits", "Birds", "Other"], id: \.self) { petType in
                        Button(action: {
                            selectedPetType = petType
                        }) {
                            Text(petType)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(selectedPetType == petType ? .white : .orange)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(selectedPetType == petType ? Color.orange : Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.orange, lineWidth: 2)
                                        )
                                )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 10)
            // Divider
            Divider()
                .background(Color.gray) // Line color
                .padding(.horizontal, 16)
            
            // Posts Grid View
            ScrollView {
                PostsGridView(posts: filteredPosts())
            }
            
            Spacer() // Placeholder for remaining content
            
            // CustomTabBar
            CustomTabBar(selectedTab: $selectedTab, showPostPetView: $showPostPetView)
        }
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            trailing: HStack(spacing: 16) {
                logoutButton
            }
        )
        .fullScreenCover(isPresented: $showPostPetView) {
            PostPetView()
        }
        
        
        
    }
    
    
    // Filtering logic for posts
    func filteredPosts() -> [PostResponse] {
        if selectedPetType == "All" {
            return postViewModel.posts // Show all posts
        } else {
            return postViewModel.posts.filter { $0.petType == selectedPetType }
        }
    }
    
}


extension MainView {
    var logoutButton: some View {
        Button(action: {
            // Logout action
            appState.isLoggedIn = false
            KeychainHelper.standard.delete(service: KeychainKeys.service, account: KeychainKeys.authToken)
        }) {
            Image(systemName: "power")
                .foregroundColor(.red)
        }
    }
}

//enum PetType: String, CaseIterable {
//    case dog, cat, rabbit, bird
//
//    var iconName: String {
//        switch self {
//        case .dog: return "pawprint"
//        case .cat: return "pawprint.circle"
//        case .rabbit: return "hare"
//        case .bird: return "bird"
//        }
//    }
//}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MainView()
//                .environmentObject(AppState())
//        }
//    }
//}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPosts = [
            PostResponse(
                id: 1,
                petName: "Buddy",
                fee: 20,
                gender: "Male",
                petType: "Dog",
                petBreed: "Golden Retriever",
                birthday: "2012-12-12",
                description: "A friendly dog",
                location: "New York",
                hasPhoto: false,
                photo: "x",
                status: "available",
                createdAt: "2022-12-12"
            ),
            PostResponse(
                id: 2,
                petName: "Mittens",
                fee: 10,
                gender: "Female",
                petType: "Cat",
                petBreed: "Siamese",
                birthday: "2015-05-01",
                description: "A cuddly cat",
                location: "Los Angeles",
                hasPhoto: false,
                photo: "x",
                status: "available",
                createdAt: "2023-05-01"
            ),
            PostResponse(
                id: 3,
                petName: "Fluffy",
                fee: 15,
                gender: "Female",
                petType: "Rabbit",
                petBreed: "Holland Lop",
                birthday: "2018-01-01",
                description: "A sweet rabbit",
                location: "Chicago",
                hasPhoto: true,
                photo: "x",
                status: "adopted",
                createdAt: "2024-01-01"
            )
        ]

        NavigationView {
            MainView()
                .environmentObject(AppState())
                .overlay(
                    ScrollView {
                        PostsGridView(posts: mockPosts) // Pass mock posts here
                    }
                )
        }
    }
}
