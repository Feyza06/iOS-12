//
//  FavoritesView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.01.25.
//


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appState: AppState
    
    
    @State private var selectedTab: CustomTabBar.Tab = .favorite
    @State private var showPostPetView: Bool = false
    
    var body: some View {
        VStack {
            
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, showPostPetView: $showPostPetView)
            
        }
        
        
        
        
        
    }
    
    
    
}
    
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
            
            
    NavigationView {
        FavoritesView()
            .environmentObject(AppState())
    }
        }
}

