//
//  FavoritesLisAssembly.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//
import UIKit

struct FavoritesLisAssembly {
    func make() -> UIViewController {
        let vc = FavoritesListVC()
        vc.title = "Favourites"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
