//
//  CustomTabBarController.swift
//  GitHubFollowers
//
//  Created by SreySros on 25/8/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPink
        viewControllers = [createSearchVC(), createFavoriteVC()]
    }
    
    func createSearchVC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteVC() -> UINavigationController {
        let favoriteVC = FavoriteVC()
        favoriteVC.title = "Favorite"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteVC)
    }

}
