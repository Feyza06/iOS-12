//
//  Main.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 16.12.24.
//


import SwiftUI

struct Main: View {

   
    @StateObject private var viewModel = PostViewModel()
    
    
   
    
    var body: some View {
        NavigationView {
            VStack {
              
                
                HStack(spacing: 30) {
                    
                    // Dog Button
                    VStack {
                        Button(action: {
                            viewModel.selectedPetType = "Dog"
                            viewModel.filterPosts()
                            
                        }) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "pawprint")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                )
                        }
                        Text("Dog")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    
                    // Cat Button
                    VStack {
                        Button(action: {
                            viewModel.selectedPetType = "Cat"
                            viewModel.filterPosts()
                        }) {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "pawprint")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                )
                        }
                        Text("Cat")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    
                    // Bird Button
                    VStack {
                        Button(action: {
                            viewModel.selectedPetType = "Bird"
                            viewModel.filterPosts()
                        }) {
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "bird")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                )
                        }
                        Text("Bird")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    
                    // Rabbit Button
                    VStack {
                        Button(action: {
                            viewModel.selectedPetType = "Rabbit"
                            viewModel.filterPosts()
                        }) {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "hare")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                )
                        }
                        Text("Rabbit")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 10)  // Add some padding to move the buttons down
                .frame(maxWidth: .infinity, alignment: .center)
                
             
                
                if viewModel.filteredPosts.isEmpty {
                    Text("No posts available")
                } else{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        
                        ForEach(viewModel.filteredPosts, id: \.id) { post in PostSquareView(post: post)
                        }
                    }
                    .padding()
                }
                
                
               
            }
        
            
            .navigationBarTitle("Pet Selector", displayMode: .inline)
            .onAppear {
                    viewModel.fetchPosts() // Fetch posts when the view appears
            }
        }
        
    }
}
        
        
        
        
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PostViewModel()
        let samplePosts: [PostResponse] = [
            PostResponse(id: 1, petName: "Buddy", fee: 20, gender: "Male", petType: "Dog", petBreed: "Golden Retriever", birthday: "2020-01-01", description: "A friendly dog", location: "New York", photo: true, status: "available", createdAt: "2024-12-12", userId: "1"),
            PostResponse(id: 2, petName: "Mittens", fee: 15, gender: "Female", petType: "Cat", petBreed: "Siamese", birthday: "2021-06-01", description: "A playful cat", location: "Los Angeles", photo: true, status: "available", createdAt: "2024-12-12", userId: "2"),
            PostResponse(id: 3, petName: "Tweety", fee: 5, gender: "Male", petType: "Bird", petBreed: "Canary", birthday: "2022-03-05", description: "A chirpy bird", location: "Chicago", photo: true, status: "available", createdAt: "2024-12-12", userId: "3"),
            PostResponse(id: 4, petName: "Thumper", fee: 10, gender: "Female", petType: "Rabbit", petBreed: "Bunny", birthday: "2020-12-02", description: "A cute rabbit", location: "San Francisco", photo: true, status: "available", createdAt: "2024-12-12", userId: "4")
        ]
        viewModel.posts = samplePosts
        viewModel.filteredPosts = samplePosts // Initially show all posts
        
        return Main()
            .environmentObject(viewModel)
    }
    
}
