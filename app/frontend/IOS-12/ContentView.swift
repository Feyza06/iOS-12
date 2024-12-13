//
//  ContentView.swift
//  IOS-12
//
//  Created by Feyza Serin on 29.10.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
           
            MainView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            
            PostPetView()
                .tabItem{
                    Image(systemName: "plus")
                    Text("New Post")
                }
            
            //Favourites
            
            ProfileView()
                           .tabItem{
                               Image(systemName: "person")
                               Text("Profile")
                           }
                       

        }
       /* VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello again")
        }
        .padding()*/
    }
}
//

#Preview {
    ContentView()
}
