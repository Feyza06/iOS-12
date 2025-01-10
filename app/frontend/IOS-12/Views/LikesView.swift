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
        Text("Favorties View")
        
        
    }
    
    
}
    
    
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        NavigationView {
            FavoritesView(selectedTab: .constant(.favorite), showPostPetView: .constant(false))
               }
    }
}
    

