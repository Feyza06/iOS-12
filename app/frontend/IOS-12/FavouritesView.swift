import SwiftUI

struct FavoriteAnimalView: View {
    @StateObject var viewModel = FavoritesViewModel()  // Verwenden von @StateObject

    var body: some View {
        NavigationView {
            VStack {
                // Ladeanzeige, wenn Favoriten geladen werden
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                else if viewModel.favorites.isEmpty {
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .font(.title3)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.favorites) { favorite in
                            HStack {
                                Text(favorite.name)
                                    .font(.headline)
                                    .foregroundColor(.brown)
                                Spacer()
                                
                                Button(action: {
                                    viewModel.removeFavorite(withId: favorite.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.fetchFavorites()  // Abrufen der Favoriten
            }
        }
    }
}

struct FavoriteAnimalView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteAnimalView()
    }
}
