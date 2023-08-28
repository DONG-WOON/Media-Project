//
//  TabBarController.swift
//  Media Project
//
//  Created by 서동운 on 8/23/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let trendingVC = TrendingViewController()
        let nav = UINavigationController(rootViewController: trendingVC)
        let trendingItem = UITabBarItem(title: SceneName.trending.rawValue, imageKey: ImageKey.trending)
        nav.tabBarItem = trendingItem
        
        let search = UINavigationController(rootViewController: SearchViewController())
        let searchItem = UITabBarItem(title: SceneName.search.rawValue, imageKey: ImageKey.search)
        search.tabBarItem = searchItem
        
        tabBar.tintColor = .black
    
        viewControllers = [nav, search]
    }
}


