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
    
    var body: some View{
        VStack(alignment: .leading) {
            ZStack{
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                
               Circle()
                    .fill(Color.white)
                    .frame(width:40, height: 40)
                    .overlay(
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .padding(20)
                    )
                    .position(x: 130, y: 40)
                    .onTapGesture {
                            isLiked.toggle()
                    }
            }
            
            
            Text(post.petType)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5) // Add padding top and bottom
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.top, 5)
                    .padding(.leading, 15)
            
            Text(post.petName)
                           .font(.headline)
                           .foregroundColor(.black)
                           .padding(.top, 5)
                           .padding(.leading, 10)
        
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

struct PostSquareView_Previews: PreviewProvider {
    static var previews: some View {
        
        
       
        let samplePost = PostResponse(
            id: 1,
            petName: "Buddy",
            fee: 20,
            gender: "Male",
            petType: "Dog",
            petBreed: "Golden Retriever",
            birthday:  "2012-12-12" ,
            description: "A friendly dog",
            location: "New York",
            photo: true,
            status: "available",
            createdAt: "2012-12-12" ,
            userId: "1"
        )
        
        PostSquareView(post: samplePost)
    }
    

    
}
