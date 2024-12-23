//
//  Folower.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//
import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String?
}

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
