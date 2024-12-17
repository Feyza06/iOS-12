//
//  APIService.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 03.12.24.
//

import Foundation
import JWTDecode


class APIService {
    static let shared = APIService()
    private init() {}

    let baseURL = "http://127.0.0.1:3000"

    // MARK: - Registration

    func register(user: [String: Any], completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let dataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(dataError))
                return
            }

            // Handle HTTP errors
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let serverError = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error: \(httpResponse.statusCode)"])
                completion(.failure(serverError))
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Login

    func login(email: String, password: String, completion: @escaping (Result<(String, User), Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email, "password": password]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let dataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(dataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                completion(.success((loginResponse.token, loginResponse.user)))
                print(loginResponse.token)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // MARK: - Fetch User Data (Protected Route)

    func fetchUserData(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/\(userId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Retrieve the token from Keychain
        if let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
           let token = String(data: tokenData, encoding: .utf8) {
            // Set the Authorization header
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            // Handle missing token
            let authError = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
            completion(.failure(authError))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                // Token is invalid or expired
                DispatchQueue.main.async {
                    // Delete the token and update app state
                    KeychainHelper.standard.delete(service: KeychainKeys.service, account: KeychainKeys.authToken)
                    // You may also want to notify the app to update UI
                }
                let authError = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Session expired. Please log in again."])
                completion(.failure(authError))
                return
            }

            guard let data = data else {
                let dataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(dataError))
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        guard let tokenData = KeychainHelper.standard.read(service: KeychainKeys.service, account: KeychainKeys.authToken),
              let token = String(data: tokenData, encoding: .utf8) else {
            let authError = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
            completion(.failure(authError))
            return
        }

        // Decode the token to extract user ID (optional)
        let userId = decodeUserIdFromToken(token: token)

        guard let url = URL(string: "\(baseURL)/users/\(userId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                // Handle unauthorized error
                completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])))
                return
            }

            guard let data = data else {
                let dataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(dataError))
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // Helper function to decode user ID from JWT token
    func decodeUserIdFromToken(token: String) -> Int {
        do {
                let jwt = try decode(jwt: token)
                if let id = jwt.claim(name: "id").integer {
                    return id
                }
            } catch {
                print("Failed to decode JWT: \(error)")
            }
            return 0 // Handle default case or error appropriately
    }
}
