//
//  NetworkError.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//
import Foundation

enum GFError: Error {
    case invalidURL(_ name: String)
    case invalidRequest(_ name: String)
    case invalidResponse(_ name: String)
    case invalidData(_ name: String)
    case unableToDecode(_ name: String)
    
    var rawValue: String {
        switch self {
        case .invalidURL(let name):
            return "[\(name)] Invalid URL"
        case .invalidRequest(let name):
            return "[\(name)] Unable to complete your request"
        case .invalidResponse(let name):
            return "[\(name)] Invalid response"
        case .invalidData(let name):
            return "[\(name)] Invalid data"
        case .unableToDecode(let name):
            return "[\(name)] Unable to decode data"
        }
    }
}
