//
//  Profile.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 26.11.24.
//

import Foundation
import SwiftUI


struct Profile: View {
    var senderId: String
    var imageUrl: URL?
    var name: String
    
    var body: some View {
        HStack {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            } placeholder: {
                ProgressView()
            }
            Text(name)
                .font(.title).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(senderId: "user1", imageUrl: URL(string: ""), name: "Adele")
            .background(Color(.gray))
    }
}


