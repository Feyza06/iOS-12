import SwiftUI

struct FavoriteAnimalView: View {
    // MARK: - Properties
    @State private var favorites: [String] = ["British Shorthair", "Golden Retriever", "Maine Coon", "Persian Cat"]
    
    @StateObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Favoritenliste
                if favorites.isEmpty {
                    // Anzeige, wenn keine Favoriten vorhanden sind
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .font(.title3)
                        .padding()
                } else {
                    List {
                        ForEach(favorites, id: \.self) { favorite in
                            HStack {
                                // Kreis-Icon als Bildplatzhalter
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.brown.opacity(0.5))
                                
                                Text(favorite)
                                    .font(.headline)
                                    .foregroundColor(.brown)
                                
                                Spacer()
                                
                                // Löschen-Button
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
            }
            .navigationTitle("Favorites")
        }
    }
    
    // MARK: - Funktion zum Entfernen eines Favoriten
    private func removeFavorite(_ favorite: String) {
        if let index = favorites.firstIndex(of: favorite) {
            favorites.remove(at: index)
        }
    }
}

// MARK: - Vorschau
#Preview {
    FavoriteAnimalView()
}
