//
//  Profile.swift
//  IOS-12
//
//  Created by Lory Cojuhari on 26.11.24.
//

import Foundation
import SwiftUI


struct Profile: View {
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1463453091185-61582044d556?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    
   
    
    var name = "noah fabian"
    
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
    }
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
