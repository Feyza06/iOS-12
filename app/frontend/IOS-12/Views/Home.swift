//
//  Home.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 10.01.25.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var appState: AppState
    
    @State private var selectedTab: CustomTabBar.Tab = .home
    @State private var showPostPetView: Bool = false
    @State private var showConversationsView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                ZStack{
                    switch selectedTab {
                    case .home:
                        MainView()
                    case .favorite:
                        FavoritesView(selectedTab: $selectedTab, showPostPetView: $showPostPetView)
                    case .addPost:
                        EmptyView()
                    case .message:
                        EmptyView() //MessageView()
                    case .profile:
                        EmptyView()
                    }
                  
                    VStack{
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab, showPostPetView: $showPostPetView, showConversationsView: $showConversationsView)
                            .padding(.bottom, 10)
                    }
                    
                }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    logoutButton
                }
            }
            .sheet(isPresented: $showPostPetView) {
                PostPetView() // Show AddPostView as a modal
                    .environmentObject(appState)
            }
            .sheet(isPresented: $showConversationsView) {
                ConversationsView()
                    .environmentObject(appState)
            }
        }
    }
}


extension Home {
    var logoutButton: some View {
        Button(action: {
            // Logout action
            appState.isLoggedIn = false
            KeychainHelper.standard.delete(service: KeychainKeys.service, account: KeychainKeys.authToken)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.orange)
                    .frame(width: 50, height: 50)
                    .shadow(radius: 4)
                Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        }
    }
    
}
    
struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            let testAppState = AppState()
            testAppState.userId = 3
            
            return Home()
                .environmentObject(testAppState)
        }
    }
    

