//
//  SearchAssembly.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//
import UIKit

struct SearchAssembly {
    func make() -> UIViewController {
        let vc = SearchVC()
        vc.title = "Search"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
