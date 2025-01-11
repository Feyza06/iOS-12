//
//  FavoritesView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.01.25.
//


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appState: AppState
    
    
    @Binding  var selectedTab: CustomTabBar.Tab
    @Binding  var showPostPetView: Bool
    
    var body: some View {
        VStack(spacing: 0){
            titleView()
                .padding(.top, -140)
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
            
            LazyVGrid(columns: columns, spacing: 25 ){
                ForEach(0..<12) { index in // Replace 12 with the count of your items
                               ZStack(alignment: .bottom) {

                                   Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                   
                                   // Caption (Optional)
                                   Text("Pet Name") // Replace with your data
                                       .font(.system(size: 14, weight: .medium))
                                       .foregroundColor(.secondary)
                                       .padding(.horizontal, 8)
                                       .padding(.vertical, 4)
                                       .background(
                                        RoundedRectangle(cornerRadius: 6)
                                                     .fill(Color.orange)
                                                     .frame(width: 100)
                                       )
                                       .padding(0)
                                   
                                   // Heart Icon at Bottom-Right
                                          VStack {
                                              Spacer() // Push the heart to the bottom
                                              HStack {
                                                  Spacer() // Push the heart to the right
                                                  ZStack {
                                                      Circle()
                                                          .fill(Color.white) // Background of the circle
                                                          .frame(width: 24, height: 24) // Adjust size as needed
                                                      Image(systemName: "heart.fill") // Heart icon
                                                          .foregroundColor(Color.red) // Red heart
                                                          .frame(width: 20, height: 20
                                                          ) // Adjust size as needed
                                                  }
                                                  .padding(4) // Add spacing from edges
                                              }
                                          }
                               }
                           }
                
            }
           
        }

    }
    
    
}

@ViewBuilder
private func titleView() -> some View {
    HStack {
        Text("Favorites")
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.primaryColor)
            .padding(.leading, 8)
        
        Spacer()
    }
    .padding(.top, 10)
    .padding(.leading, 16)
    .padding(.bottom, 10)
}

    
    
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        NavigationView {
            FavoritesView(selectedTab: .constant(.favorite), showPostPetView: .constant(false))
               }
    }
}
    

