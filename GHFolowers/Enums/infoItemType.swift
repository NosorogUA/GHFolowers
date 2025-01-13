//
//  infoItemType.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 26.12.2024.
//
import UIKit

enum infoItemType {
    case repos, gists, followers, following
    
    var title: String {
        switch self {
        case .repos: return "Public Repos"
        case .gists: return "Public Gists"
        case .followers: return "Followers"
        case .following: return "Following"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .repos: return UIImage(systemName: SFSymbols.repos)
        case .gists: return UIImage(systemName: SFSymbols.gists)
        case .followers: return UIImage(systemName: SFSymbols.followers)
        case .following: return UIImage(systemName: SFSymbols.following)
        }
    }
}
