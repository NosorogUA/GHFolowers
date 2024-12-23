//
//  Folower.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//
import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String?
}

struct User: Codable {
    let login: String
    let avatarUrl: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
