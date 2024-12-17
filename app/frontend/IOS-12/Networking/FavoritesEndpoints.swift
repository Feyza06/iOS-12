//
//  FavoritesEndpoints.swift
//  IOS-12
//
//  Created by Lisa Mustafa on 16.12.24.
//

import Foundation

//AddFavoritesEndpoint

struct AddFavoritesEndpoint: APIEndpointType {
    var baseURL: String { "http://localhost:3000" } // Server-URL
    var path: String { "/favorites" } // Endpoint für Favoriten
    var method: HTTPMethod { .POST } // HTTP-Methode: POST
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    
    var body: Encodable? { favourite } // Die Favoriten-Daten als JSON-Daten

    let favourite: Favourite // Favoriten-Datenmodell

    // Initialisierung des Endpunkts mit einem Favoriten
    init(favourite: Favourite) {
        self.favourite = favourite
    }
}

    //RemoveFavoritesEndpoint
    
struct RemoveFavoritesEndpoint: APIEndpointType {
    var baseURL: String { "http://localhost:3000" } // Basis-URL des Servers
    var path: String { "/favorites/\(favoriteID)" } // Endpoint mit Favoriten-ID
    var method: HTTPMethod { .DELETE } // HTTP-Methode: DELETE
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var body: Encodable? { nil } // DELETE-Anfragen haben normalerweise keinen Body
    
    let favoriteID: String // ID des Favoriten, der entfernt werden soll

    init(favoriteID: String) {
        self.favoriteID = favoriteID
    }
}

     //DisplayFavoritesEndpoint

struct DisplayFavoritesEndpoint: APIEndpointType {
    var baseURL: String { "http://localhost:3000" } // Basis-URL des Servers
    var path: String { "/favorites" } // Endpoint für alle Favoriten
    var method: HTTPMethod { .GET } // HTTP-Methode: GET
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var body: Encodable? { nil } // GET-Anfragen haben keinen Body
}

        
    
    
    
    

 
