//
//  PetDetailViewModel.swift
//  IOS-12
//
//  Created by Lisa Mustafa on 02.01.25.
//
import Foundation


class PetDetailModelView: ObservableObject {
    @Published var isFavorite: Bool = false
    @Published var error: Error? = nil

    private let apiManager = APIManager.shared
    
    /// Favorit hinzufügen
    func addFavorite(pet: Pet, completion: @escaping (Result<Void, Error>) -> Void) {
        // Konvertiere UUID in String für das `Favourite`-Objekt
        let favorite = Favourite(id: pet.id.uuidString, name: pet.name, type: pet.species.rawValue)
        
        let endpoint = AddFavoritesEndpoint(favourite: favorite)
        
        apiManager.request(modelType: Favourite.self, type: endpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isFavorite = true
                    completion(.success(()))
                case .failure(let apiError):
                    self.error = apiError
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    /// Favorit entfernen
    func removeFavorite(petID: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        // Konvertiere UUID in String
        let endpoint = RemoveFavoritesEndpoint(favoriteID: petID.uuidString)
        
        apiManager.request(modelType: Favourite.self, type: endpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isFavorite = false
                    completion(.success(()))
                case .failure(let apiError):
                    self.error = apiError
                    completion(.failure(apiError))
                }
            }
        }
    }
}
