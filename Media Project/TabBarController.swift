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
        let trendingItem = UITabBarItem(title: "Trending", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis"))
        trending.tabBarItem = trendingItem
        
        let search = UINavigationController(rootViewController: SearchViewController())
        let searchItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        search.tabBarItem = searchItem
        
        tabBar.tintColor = .black
    
        viewControllers = [trending, search]
    }
}


