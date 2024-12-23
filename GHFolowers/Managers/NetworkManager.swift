//
//  NetworkManager.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl: String = "https://api.github.com"
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        let path = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url: URL = .init(string: path) else {
            completion(.failure(GFError.invalidURL(#function)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(GFError.invalidRequest(#function)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(GFError.invalidResponse(#function)))
                return
            }
            
            guard let data else {
                completion(.failure(GFError.invalidData(#function)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers: [Follower] = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(GFError.unableToDecode(#function + "[Follower]")))
            }
            
        }
        task.resume()
    }
}
