import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Favourite] = []  // Liste der Favoriten
    @Published var isLoading: Bool = false      // Ladeanzeige
    @Published var error: Error? = nil          // Fehlerzustand
    
    // API-Manager verwenden
    private let apiManager = APIManager.shared
    
    
    func isFavorite(_ id: String) -> Bool {
        return favorites.contains(where: { $0.id == id })
    }
    
    
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
    
    func addFavorite(_ favorite: Favourite, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            self.favorites.append(favorite)
            completion(.success(()))
        }
    }
    
    func removeFavorite(withId id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            if let index = self.favorites.firstIndex(where: { $0.id == id }) {
                self.favorites.remove(at: index)
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "Not Found", code: 404, userInfo: nil)))
            }
        }
    }
}
