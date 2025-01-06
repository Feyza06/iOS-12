//
//  CustomTabBar.swift
//  IOS-12
//
//  Created by Feyza Serin on 17.12.24.
//
import SwiftUI

struct CustomTabBar: SwiftUI.View {
    @Binding var selectedTab: Tab
    @Binding var showPostPetView: Bool // Bindung für die Navigation

    enum Tab: CaseIterable {
        case home, favorite, addPost, message, profile
        
        var iconName: String {
            switch self {
            case .home: return "house.fill"
            case .favorite: return "heart.fill"
            case .addPost: return "plus.circle.fill"
            case .message: return "envelope.fill"
            case .profile: return "person.fill"
            }
        }
    }
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Button(action: {
                    if tab == .addPost {
                        showPostPetView = true // Aktiviert den Vollbildmodus
                    } else {
                        selectedTab = tab
                    }
                }) {
                    ZStack {
                        if tab == .addPost {
                            Circle()
                                .foregroundColor(Color.orange)
                                .frame(width: 60, height: 60)
                                .shadow(radius: 4)
                            Image(systemName: tab.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: tab.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedTab == tab ? Color.orange : Color.gray)
                        }
                    }
                }
                Spacer()
            }
        }
        .frame(height: 70)
        .background(Color.white.shadow(radius: 2))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
