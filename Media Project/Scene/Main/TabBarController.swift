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
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let trendingVC = sb.instantiateViewController(identifier: TrendingViewController.identifier) as? TrendingViewController else { return }
    
        let trending = UINavigationController(rootViewController: trendingVC)
        let trendingItem = UITabBarItem(title: SceneName.trending.rawValue, imageKey: ImageKey.trending)
        trending.tabBarItem = trendingItem
        
        let search = UINavigationController(rootViewController: SearchViewController())
        let searchItem = UITabBarItem(title: SceneName.search.rawValue, imageKey: ImageKey.search)
        search.tabBarItem = searchItem
        
        tabBar.tintColor = .black
    
        viewControllers = [trending, search]
    }
}


