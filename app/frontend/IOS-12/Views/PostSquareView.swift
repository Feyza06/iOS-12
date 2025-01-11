//
//  PostSquareView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 16.12.24.
//
import SwiftUI

struct PostSquareView: View {
    @State private var isLiked: Bool = false
    let post: PostResponse
    
    var body: some View {

            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    // Placeholder image or dynamic content
                    if let photoPath = post.photo,
                       let imageUrl = URL(string: "http://127.0.0.1:3000" + photoPath),
                       post.hasPhoto{
                        AsyncImage(url: imageUrl) { image in image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 150, height: 140)
                        .clipped()
                        .cornerRadius(15)
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 150, height: 140)
                                .cornerRadius(15)
                            
                            // Inner light gray rectangle
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(width: 140, height: 140)
                                .cornerRadius(10)
                        }
                    }
                    
                    // Heart button
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        )
                        .padding(8)
                        .onTapGesture {
                            isLiked.toggle()
                        }
                }
                .padding(.top, 15) // Add top padding here
                
                // Pet Type Tag
                Text(post.petType)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding(.top, 5)
                    .padding(.leading, 10)
                
                // Pet Name
                Text(post.petName)
                    .font(.headline)
                    .foregroundColor(.primaryColor)
                    .padding(.top, 5)
                    .padding(.leading, 10)
                
                // Pet Breed
                Text(post.petBreed)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                    .padding(.bottom, 30)
            }
            .frame(width: 170, height: 260)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }

//struct PostSquareView_Previews: PreviewProvider {
//    static var previews: some View {
//        let samplePost = PostResponse(
//            id: 1,
//            petName: "Buddy",
//            fee: 20,
//            gender: "Male",
//            petType: "Dog",
//            petBreed: "Golden Retriever",
//            birthday: "2012-12-12", // Use string representation
//            description: "A friendly dog",
//            location: "New York",
//            hasPhoto: false,
//            photo: "x",
//            status: "available",
//            createdAt: "2012-12-12" // Use string representation
//           // userId: "1"
//        )
//
//        PostSquareView(post: samplePost)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}


struct PostsGridView: View {
    let posts: [PostResponse] // Array of posts to display

    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]

        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(posts, id: \.id) { post in
                    NavigationLink(destination:  PetDetailView(post: post)){
                        PostSquareView(post: post)
                    }
                }
            }
            .padding(16) // Add padding around the grid
        }
    }
}

//struct PostsGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        let samplePosts = [
//            PostResponse(
//                id: 1,
//                petName: "Buddy",
//                fee: 20,
//                gender: "Male",
//                petType: "Dog",
//                petBreed: "Golden Retriever",
//                birthday: "2012-12-12",
//                description: "A friendly dog",
//                location: "New York",
//                hasPhoto: false,
//                photo: "x",
//                status: "available",
//                createdAt: "2012-12-12"
//             //   userId:"1"
//            ),
//            PostResponse(
//                id: 2,
//                petName: "Mittens",
//                fee: 10,
//                gender: "Female",
//                petType: "Cat",
//                petBreed: "Siamese",
//                birthday: "2015-05-01",
//                description: "A cuddly cat",
//                location: "Los Angeles",
//                hasPhoto: false,
//                photo: "x",
//                status: "available",
//                createdAt: "2015-05-01"
//              //  userId:"1"
//            ),
//            PostResponse(
//                id: 3,
//                petName: "Mittens",
//                fee: 10,
//                gender: "Female",
//                petType: "Cat",
//                petBreed: "Siamese",
//                birthday: "2015-05-01",
//                description: "A cuddly cat",
//                location: "Los Angeles",
//                hasPhoto: false,
//                photo: "x",
//                status: "available",
//                createdAt: "2015-05-01"
//              //  userId:"1"
//            ),
//            PostResponse(
//                id: 4,
//                petName: "Mittens",
//                fee: 10,
//                gender: "Female",
//                petType: "Cat",
//                petBreed: "Siamese",
//                birthday: "2015-05-01",
//                description: "A cuddly cat",
//                location: "Los Angeles",
//                hasPhoto: false,
//                photo: "x",
//                status: "available",
//                createdAt: "2015-05-01"
//                //userId:"1"
//            )
//        ]
//
//        PostsGridView(posts: samplePosts)
//            .previewLayout(.sizeThatFits)
//    }
//}
