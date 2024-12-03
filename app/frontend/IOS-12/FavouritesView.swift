//
//  FavouritesView.swift
//  IOS-12
//
//  Created by Lisa Mustafa on 02.12.24.
//

import SwiftUI

struct FavoriteAnimalView: View {
    @State private var favorites: [String] = ["British shorthair"]
    @State private var newFavorite: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Eingabefeld zum Hinzufügen neuer Favoriten
                HStack {
                    TextField("Add new pet", text: $newFavorite)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        addFavorite()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .padding(.trailing)
                }
                
                // Liste der Favoriten
                List {
                    ForEach(favorites, id: \.self) { favorite in
                        HStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.brown.opacity(0.5)) // Kreis für Bildplatzhalter
                            
                            Text(favorite)
                                .font(.headline)
                                .foregroundColor(.brown)
                            
                            Spacer()
                            
                            Button(action: {
                                removeFavorite(favorite)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Favori")
        }
    }

    // Funktion zum Hinzufügen neuer Favoriten
    private func addFavorite() {
        guard !newFavorite.isEmpty else { return }
        favorites.append(newFavorite)
        newFavorite = ""
    }

    // Funktion zum Entfernen eines Favoriten
    private func removeFavorite(_ favorite: String) {
        if let index = favorites.firstIndex(of: favorite) {
            favorites.remove(at: index)
        }
    }
}

struct FavouritesView: View {
    var body: some View {
        FavoriteAnimalView() // Einbindung der View
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}




