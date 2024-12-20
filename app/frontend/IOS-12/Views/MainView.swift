//
//  MainView.swift
//  IOS-12
//
//  Created by Feyza Serin on 07.11.24.
//



import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    // View Model
    @StateObject private var postViewModel = PostViewModel()
    
    @State private var selectedTab: CustomTabBar.Tab = .home
    @State private var showPostPetView: Bool = false
    
    @State private var selectedPetType: PetType = .dog
    
    @State private var locationSearchText: String = ""
    
    
    var body: some View {
        VStack {
            HStack {
                        Image(systemName: "mappin.circle.fill") // Location icon
                            .foregroundColor(.primaryColor) // Use your custom primary color
                            .font(.system(size: 24))
                            .padding(.leading, 10)
                        
                        TextField("Enter location", text: $locationSearchText)
                            .foregroundColor(.darkText) // Use your custom dark text color
                            .padding(10)
                    }
                    .frame(width: 300)
                  
                    .background(Color.primaryLight) // Use your custom primary light color
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.lightGrey, lineWidth: 1) // Add border
                    )
                    
                    .padding(.horizontal, 10) // Add padding around the whole text field
            
            HStack(spacing: 20){
                ForEach(PetType.allCases, id: \.self) { petType in
                    Button(action: {
                        selectedPetType = petType
                    }) {
                        VStack {
                            Image(systemName: petType.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(selectedPetType == petType ? .primaryColor : .gray)
                                .padding()
                            Text(petType.rawValue.capitalized)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(selectedPetType == petType ? .primaryColor : .gray)
                        }
                        .background( RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedPetType == petType ? Color.primaryColor : Color.gray, lineWidth: 2) )
                    }
                }
            }
            .padding()
            
            
            
            
            Spacer()
            
            // CustomTabBar integration
            CustomTabBar(selectedTab: $selectedTab, showPostPetView: $showPostPetView)
        }
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            trailing: HStack(spacing: 16) {
                logoutButton
            }
        )
        .fullScreenCover(isPresented: $showPostPetView) {
            PostPetView()
        }
    }
}

extension MainView {
    var logoutButton: some View {
        Button(action: {
            // Logout action
            appState.isLoggedIn = false
            // Optionally, delete the auth token from the Keychain
            KeychainHelper.standard.delete(service: KeychainKeys.service, account: KeychainKeys.authToken)
        }) {
            Image(systemName: "power")
                .foregroundColor(.red)
        }
    }
}

enum PetType: String, CaseIterable {
    case dog, cat, rabbit, bird

    var iconName: String {
        switch self {
        case .dog: return "pawprint"
        case .cat: return "pawprint.circle"
        case .rabbit: return "hare"
        case .bird: return "bird"
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
                .environmentObject(AppState())
        }
    }
}
