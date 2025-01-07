//
//  APIService.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 03.12.24.
//

import Foundation
import UIKit
import JWTDecode

class APIService {
    static let shared = APIService()
    private init() {}
    
    // MARK: - Register (Multipart)
    func registerUserWithImage(
        firstName: String,
        lastName: String,
        username: String,
        email: String,
        password: String,
        image: UIImage?,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        // Construct the endpoint
        let endpoint = RegisterUserWithImageEndpoint(
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email,
            password: password,
            image: image
        )
        
        // Call APIManager
        APIManager.shared.requestDataVoid(endpoint: endpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let networkError):
                    // Convert `NetworkError` to an NSError (optional)
                    let nsError = NSError(
                        domain: "",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: networkError.localizedDescription]
                    )
                    completion(.failure(nsError))
                }
            }
        }
    }
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<(String, User), Error>) -> Void) {
        let endpoint = LoginEndpoint(email: email, password: password)
        
        APIManager.shared.request(modelType: LoginResponse.self, type: endpoint) { result in
            switch result {
            case .success(let loginResponse):
                completion(.success((loginResponse.token, loginResponse.user)))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
    
    // MARK: - Fetch User Data
    func fetchUserData(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let endpoint = FetchUserEndpoint(userId: userId)
        
        APIManager.shared.request(modelType: User.self, type: endpoint) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
    
    // MARK: - Current User
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        // Read token from Keychain
        guard let tokenData = KeychainHelper.standard.read(
                service: KeychainKeys.service,
                account: KeychainKeys.authToken
              ),
              let token = String(data: tokenData, encoding: .utf8) else {
            let authError = NSError(
                domain: "",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]
            )
            completion(.failure(authError))
            return
        }
        
        let userId = decodeUserIdFromToken(token: token)
        let endpoint = FetchUserEndpoint(userId: userId)
        
        APIManager.shared.request(modelType: User.self, type: endpoint) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Helper to decode the user ID from the JWT
    func decodeUserIdFromToken(token: String) -> Int {
        do {
            let jwt = try decode(jwt: token)
            if let id = jwt.claim(name: "id").integer {
                return id
            }
        } catch {
            print("Failed to decode JWT: \(error)")
        }
        return 0 // or handle error
    }
}
