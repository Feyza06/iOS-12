//
//  PetDetailView.swift
//  IOS-12
//
//  Created by Feyza Serin on 07.11.24.
//

import SwiftUI

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
    
//    private var leadingView: some View {
//        NavigationLink(
//            destination: MainView()
//        ) {
//            Image(systemName: "arrow.left")
//                .foregroundColor(.primaryColor)
//                .frame(width: 36, height: 36)
//                .background(Color.white)
//                .cornerRadius(18)
//        }
//    }
    
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
                            case .success(let image): image
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
                           // Display a gray placeholder with a system image
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
                        
                        HStack(spacing: 80){
                            VStack(alignment: .leading){
                                Text("Name")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(.primaryColor)
                                Text(post.petName)
                            }
                            
                            VStack(alignment: .leading){
                                Text("Breed")
                                    .font(.system(size:23, weight: .bold))
                                    .foregroundColor(.primaryColor)
                                Text(post.petBreed)
                            }
                        }
                        
                        
                        Text("Description")
                            .font(.system(size:23, weight: .bold))
                            .foregroundColor(.primaryColor)
                        Text(post.description)
                        
                        Text("Address")
                            .font(.system(size:23, weight: .bold))
                            .foregroundColor(.primaryColor)
                        Text(post.location)
                        
                        Button(action: {
                            // Action to calculate or map the distance
                            showDistanceView = true
                            print("Map Distance button tapped")
                        }) {
                            HStack {
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20) // Adjust size
                                    .foregroundColor(.primaryColor) // Set color for the icon
                                
                                Text("Map Distance")
                                    .font(.system(size: 16, weight: .medium)) // Adjust font size and weight
                                    .foregroundColor(.primaryColor) // Set color for the text
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white)) // Add rounded corners and background
                        .shadow(radius: 3)
                        .sheet(isPresented: $showDistanceView) {
                            DistanceView()
                                .environmentObject(AppState())
                        }
                        
                    }
                    .foregroundColor(.darkText)
                    .padding()
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                // Action buttons
                HStack {
                    NavigationLink(
                        destination: ChatView(
                            currentUserId: appState.userId ?? 0, // Current user
                            otherUserId: Int(post.userId) ?? 0,  // Post owner
                            otherUsername: post.petName,         // Display name in chat
                            postId: post.id                      // Pass post ID for context
                        )
                    ) {
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
                }
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: trailingView)
            
        }
        
        
    }
    
    struct BoxDetailView: View {
        let icon: String
        let description: String
        
        var body: some View {
            VStack {
                Image(systemName: icon) // Use the SF Symbol for the icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 24) // Adjust icon size
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
    
    //struct PetDetailPreview: PreviewProvider {
    //
    //    static var previews: some View {
    //        NavigationView {
    //            if let pet = PetData.dogs.first {
    //                PetDetailView(post: PostResponse)
    //            } else {
    //                Text("No pets available")
    //            }
    //        }
    //    }
    //}
    
    //struct PetDetailView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        let samplePost = PostResponse(
    //            id: 1,
    //            petName: "Buddy",
    //            fee: 20,
    //            gender: "Male",
    //            petType: "Dog",
    //            petBreed: "Golden Retriever",
    //            birthday: "2012-12-12",
    //            description: "A friendly dog looking for a home.",
    //            location: "New York",
    //            hasPhoto: false,
    //            photo: nil,
    //            status: "available",
    //            createdAt: "2022-12-12",
    //            userId: "1"
    //        )
    //
    //        NavigationView {
    //            PetDetailView(post: samplePost)
    //        }
    //    }
    //}
    
    struct PetDetailView_Previews: PreviewProvider {
        static var previews: some View {
            // Sample PostResponse data for preview
            let samplePost = PostResponse(
                id: 1,
                petName: "Buddy",
                fee: 20.0,
                gender: "Male",
                petType: "Dog",
                petBreed: "Golden Retriever",
                birthday: "2020-01-01",
                description: "Buddy is a friendly and playful Golden Retriever looking for a loving home.",
                location: "New York, USA",
                hasPhoto: true,
                photo: "/uploads/1736588036486-postphoto.jpg", // Replace with actual image URL or nil
                status: "Available",
                createdAt: "2023-01-01",
                userId: "123"
            )
            
            NavigationView {
                PetDetailView(post: samplePost)
                    .environmentObject(AppState()) // Inject AppState for the environment
            }
        }
    }

