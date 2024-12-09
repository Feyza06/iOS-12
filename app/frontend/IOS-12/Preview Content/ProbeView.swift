//
//  ProbeView.swift
//  IOS-12
//
//  Created by Anastasia Petri on 26.11.24.
//

import SwiftUI

struct ProbeView: View {
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
            }
            .padding()
            
            // Profilbild und Name
            VStack(spacing: 16) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                
                VStack {
                    Text("Username")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Firstname Lastname")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical)
            
            // About You Box
            Text("About you")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding()
            
            // Posts Grid
            VStack(alignment: .leading) {
                Text("Posts")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                    ForEach(1...9, id: \.self) { index in
                        Text("Post \(index)")
                            .frame(width: 100, height: 100)
                            .background(Color(.systemGray4))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(red: 1.0, green: 0.95, blue: 0.9))
    }
}

#Preview {
    ProbeView()
}
