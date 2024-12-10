//
//  Profile.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 26.11.24.
//

import Foundation
import SwiftUI


struct Profile: View {
    var imageUrl = URL(string: "https://drive.google.com/uc?export=view&id=1K2_vBti-gyPMracSZHa7uZylxwHwlslz")
    
    var name = "adele"
    
    var body: some View {
        HStack{
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:50, height: 50)
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
        Profile()
            .background(Color(.gray))
    }
}
