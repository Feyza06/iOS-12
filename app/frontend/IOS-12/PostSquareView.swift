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
                if post.photo {
                    Image("petPlaceholder") // Replace with actual image handling if available
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(15)
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 150, height: 160)
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
                    .frame(width: 40, height: 40)
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
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top, 5)
                .padding(.leading, 10)

            // Pet Name
            Text(post.petName)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 5)
                .padding(.leading, 10)

            // Pet Breed
            Text(post.petBreed)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading, 10)
                .padding(.bottom, 10)
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
//            photo: false,
//            status: "available",
//            createdAt: "2012-12-12", // Use string representation
//            userId: "1"
//        )
//
//        PostSquareView(post: samplePost)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
