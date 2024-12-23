//
//  NetworkManager.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//

import Foundation
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl: String = "https://api.github.com"
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        let path = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url: URL = .init(string: path) else {
            completion(.failure(GFError.invalidURL(#function)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
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
    
    func getUserInfo(for username: String, completion: @escaping(Result<User, GFError>) -> Void) {
        let path = baseUrl + "/users/\(username)"
        guard let url: URL = .init(string: path) else {
            completion(.failure(GFError.invalidURL(#function)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
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
                let user: User = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(GFError.unableToDecode(#function + "User")))
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String?, completion: @escaping(UIImage?) -> Void) {
        
        guard let urlString, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let cacheKey = NSString(string: urlString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            print("From cache")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if error != nil {
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil)
                return
            }
            
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
