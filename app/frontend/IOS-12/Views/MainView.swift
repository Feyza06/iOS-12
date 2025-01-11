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
    @State private var selectedPetType: String = "All"
    
    @State private var showPostPetView: Bool = false
    
   // @State private var filteredPosts: [PostResponse] = []
    
    
//    let mockPosts = [
//        PostResponse(
//            id: 1,
//            petName: "Buddy",
//            fee: 20,
//            gender: "Male",
//            petType: "Dog",
//            petBreed: "Golden Retriever",
//            birthday: "2012-12-12",
//            description: "A friendly dog",
//            location: "New York",
//            hasPhoto: false,
//            photo: "x",
//            status: "available",
//            createdAt: "2022-12-12"
//        ),
//        PostResponse(
//            id: 2,
//            petName: "Mittens",
//            fee: 10,
//            gender: "Female",
//            petType: "Cat",
//            petBreed: "Siamese",
//            birthday: "2015-05-01",
//            description: "A cuddly cat",
//            location: "Los Angeles",
//            hasPhoto: false,
//            photo: "x",
//            status: "available",
//            createdAt: "2023-05-01"
//        ),
//        PostResponse(
//            id: 3,
//            petName: "Fluffy",
//            fee: 15,
//            gender: "Female",
//            petType: "Rabbit",
//            petBreed: "Holland Lop",
//            birthday: "2018-01-01",
//            description: "A sweet rabbit",
//            location: "Chicago",
//            hasPhoto: false,
//            photo: "x",
//            status: "adopted",
//            createdAt: "2024-01-01"
//        )
//    ]
    
    var body: some View {
        VStack {
            titleView()
            
            
           petTypeScrollView()
           
            Divider()
                .background(Color.gray) // Line color
                .padding(.horizontal, 16)
            
            
            if postViewModel.isUploading {
                ProgressView("Loading posts...")
                    .padding(.top, 20)
            } else if !postViewModel.posts.isEmpty{
                ScrollView {
                                  VStack {
                                      PostsGridView(posts: postViewModel.filteredPosts)
                                          .padding(.horizontal, 16)
                                  }
                                  .padding(.top, 5)
                                  .padding(.bottom, 10)
                              }
            } else if let errorMessage = postViewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("No posts available")
                    .padding()
            }

            Spacer()
            
//            CustomTabBar(selectedTab: $selectedTab, showPostPetView: $showPostPetView)
        }
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            postViewModel.getPosts()
        }
        .fullScreenCover(isPresented: $showPostPetView) {
            PostPetView()
        }
        
    }
    
    @ViewBuilder
    private func titleView() -> some View {
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
    }
    
    
    // Extracted Scrollable Row View
    @ViewBuilder
    private func petTypeScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                Button(action: {
                    selectedPetType = "All"
                    postViewModel.filteredPosts = postViewModel.posts // Show all posts
                }) {
                   Text("All")
                       .font(.system(size: 16, weight: .medium))
                       .foregroundColor(selectedPetType == "All" ? .white : .orange)
                       .padding(.horizontal, 16)
                       .padding(.vertical, 8)
                       .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedPetType == "All" ? Color.orange : Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.orange, lineWidth: 2)))
                }

                // Pet type buttons
                ForEach(["Dog", "Cat", "Rabbit", "Birds", "Other"], id: \.self) { petType in
                    Button(action: {
                        selectedPetType = petType
                        postViewModel.filteredPosts = postViewModel.posts.filter { $0.petType.lowercased() == petType.lowercased() }
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
    }
    
}






struct MainView_Previews: PreviewProvider {
    static var previews: some View {
     

        
            MainView()
                .environmentObject(AppState())

        
    }
}
