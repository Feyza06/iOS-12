//
//  ProfileView.swift
//  IOS-12
//
//  Created by Anastasia Petri on 01.12.24.
//

import SwiftUI

struct ProfileView: View {

    @State private var showEditProfile = false
    @State private var profileData = UserProfileData(
        username: "Username",
        firstname: "Firstname",
        lastname: "Lastname",
        profileImage: nil
    )

    @State private var isLoading = false  // Zum Verwalten des Ladezustands

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1.0, green: 0.95, blue: 0.9).edgesIgnoringSafeArea(
                    .all)

                VStack {
                    //header + menubutton
                    HStack {
                        Text("Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(
                                Color(red: 0.55, green: 0.27, blue: 0.07))

                        Spacer()
                            //menüanzeige
                            .toolbar {
                                ToolbarItem {
                                    Menu {
                                        Button(action: {
                                            // Dein Code für "Edit Profile"
                                            showEditProfile = true
                                        }) {
                                            Text("Edit Profile")
                                        }
                                    } label: {
                                        Label(
                                            "Menu",
                                            systemImage: "line.3.horizontal"
                                        )
                                        .foregroundColor(.brown)
                                        .bold()
                                    }
                                }
                            }
                    }
                    .padding()
                    //profilepicture + userinfo
                    VStack {
                        if let image = profileData.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 4)
                                )
                                .shadow(radius: 5)
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        }

                        VStack(alignment: .center) {
                            Text(profileData.username)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(
                                "\(profileData.firstname) \(profileData.lastname)"
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical)

                    Divider()

                    //post
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Post")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(
                                    Color(red: 0.55, green: 0.27, blue: 0.07)
                                )
                                .padding(.horizontal)
                                .padding(.top)

                            LazyVGrid(
                                columns: Array(
                                    repeating: GridItem(
                                        .flexible(), spacing: 16), count: 3),
                                spacing: 16
                            ) {
                                ForEach(1...9, id: \.self) { index in
                                    Text("Post \(index)")
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(1, contentMode: .fill)
                                        .background(Color(.systemGray4))
                                        .cornerRadius(12)
                                        .shadow(
                                            color: Color.black.opacity(0.1),
                                            radius: 5, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showEditProfile) {
                ProfileEdit(profileData: $profileData)
            }
        }
    }
    /*private func fetchUserProfile(){
        guard let userID = getUserID() else{
            print("Fehler konnte nicht abgerufen werden")
            return 
        }
    }*/
    private func getUserID() -> Int? {
        // Abrufen der Benutzer-ID aus dem Keychain
        if let userIDData = KeychainHelper.standard.read(service: "com.yourapp.service", account: "userID") {
            // Konvertiere die Daten in einen String
            if let userIDString = String(data: userIDData, encoding: .utf8) {
                // Konvertiere den String in eine Integer ID
                if let userID = Int(userIDString) {
                    return userID
                } else {
                    print("Fehler: Benutzer-ID kann nicht in eine Integer umgewandelt werden.")
                    return nil
                }
            } else {
                print("Fehler: Benutzer-ID kann nicht als String gelesen werden.")
                return nil
            }
        } else {
            print("Fehler: Keine Benutzer-ID im Keychain gefunden.")
            return nil
        }
    }
  
 /*   private func fetchUserProfile() {
        guard let userID = getUserID() else {
            print ("Fehler id konnte nicht abgerufen werden")
            return
        }
        isLoading = true
        let endpoint = ProfileEndpoint.fetchProfile(userID: userID)
       // APIClient.shared.request(endpoint) { (result: Result<UserProfileData, Error>) in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.profileData = profile
                    self.isLoading = false
                }
            case .failure(let error):
                print("Error loading profile: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }

        }
    }
  */
   
}
#Preview {
    ProfileView()
}
