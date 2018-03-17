//
//  MainTabViewController.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        tabBar.backgroundColor = .black
        
        //tabBar.isTranslucent = false
        
        //35 35 35
        setupBarItems()
        let tabBarItemApperance = UITabBarItem.appearance()
        tabBarItemApperance.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 10)!, NSAttributedStringKey.foregroundColor: UIColor.gray], for: .normal)
        tabBarItemApperance.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 10)!, NSAttributedStringKey.foregroundColor: primaryColor], for: .selected)
    }
    
    private func setupBarItems(){
        let controller1 = MoviesVC()
        controller1.tabBarItem = UITabBarItem(title: "MOVIES", image: #imageLiteral(resourceName: "movie_fill_icon"), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        nav1.toolbar.isHidden = true
        
        let controller2 = TVViewController()
        controller2.tabBarItem = UITabBarItem(title: "TV", image: #imageLiteral(resourceName: "tv_line_icon"), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let controller3 = ProfileVC()
        controller3.tabBarItem = UITabBarItem(title: "PROFILE", image: #imageLiteral(resourceName: "profile_line_icon"), tag: 3)
        
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = ""
        
        viewControllers = [nav1, nav2, nav3]
        
    }
}

