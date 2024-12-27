import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Favourite] = []  // Liste der Favoriten
    @Published var isLoading: Bool = false      // Ladeanzeige
    @Published var error: Error? = nil          // Fehlerzustand
    
    // API-Manager verwenden
    private let apiManager = APIManager.shared
    
    // Abrufen der Favoriten
    func fetchFavorites() {
        isLoading = true
        error = nil
        
        // Endpoint für das Abrufen der Favoriten
        let endpoint = DisplayFavoritesEndpoint()
        
        apiManager.request(modelType: [Favourite].self, type: endpoint) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedFavorites):
                    self.favorites = fetchedFavorites
                case .failure(let apiError):
                    self.error = apiError
                }
            }
        }
    }
    
    // Hinzufügen eines Favoriten
    func addFavorite(_ favorite: Favourite) {
        isLoading = true
        error = nil
        
        // Endpunkt für das Hinzufügen eines Favoriten
        let endpoint = AddFavoritesEndpoint(favourite: favorite)
        
        apiManager.request(modelType: Favourite.self, type: endpoint) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let addedFavorite):
                    self.favorites.append(addedFavorite) // Neuer Favorit zur Liste hinzufügen
                case .failure(let apiError):
                    self.error = apiError
                }
            }
        }
    }
    
    // Entfernen eines Favoriten
    func removeFavorite(withId favoriteID: String) {
        isLoading = true
        error = nil
        
        // Endpunkt für das Entfernen eines Favoriten
        let endpoint = RemoveFavoritesEndpoint(favoriteID: favoriteID)
        
        apiManager.request(modelType: Favourite.self, type: endpoint) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Entferne den Favoriten aus der Liste
                    self.favorites.removeAll { $0.id == favoriteID }
                case .failure(let apiError):
                    self.error = apiError
                }
            }
        }
    }
}
