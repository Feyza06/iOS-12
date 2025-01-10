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
    
    //let pet: Pet
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
//                ZStack(alignment: Alignment.bottom) {
//                    // Image Carousel with Tap to View Full-Screen
//                    TabView(selection: $currentIndex) {
//                        ForEach(0..<post.images.count, id: \.self) { index in
//                            Image(post.images[index])
//                                .resizable()
//                                .scaledToFill()
//                                .onTapGesture {
//                                    selectedImage = post.images[index]
//                                    isFullScreen = true
//                                }
//                                .tag(index)
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//                    .frame(height: 355)
//                }
//                .frame(height: 355, alignment: .center)
                
                // Pet Details Section
                HStack(spacing: 20) {
                    BoxDetailView(title: "Age", description: " x Months")
                    BoxDetailView(title: "Weight", description: String(format: "%.1f kg"))
                    BoxDetailView(title: "Sex", description: "gen")
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Name")
                            .font(.system(size: 18, weight: .medium))
                        Spacer()
                        Text("Breed")
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
                    
                    Text(post.description)
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

struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePost = PostResponse(
            id: 1,
            petName: "Buddy",
            fee: 20,
            gender: "Male",
            petType: "Dog",
            petBreed: "Golden Retriever",
            birthday: "2012-12-12",
            description: "A friendly dog looking for a home.",
            location: "New York",
            hasPhoto: false,
            photo: nil,
            status: "available",
            createdAt: "2022-12-12"
        )
        
        NavigationView {
            PetDetailView(post: samplePost)
        }
    }
}
