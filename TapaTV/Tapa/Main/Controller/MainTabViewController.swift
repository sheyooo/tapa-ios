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
    
    override func viewDidLayoutSubviews() {
//        var tabFrame = self.tabBar.frame
//        tabFrame.size.height = Constant.isCompact(view: view, yes: 50, no: 60)
//        tabFrame.origin.y = self.view.frame.size.height - Constant.isCompact(view: view, yes: 50, no: 60)
//        self.tabBar.frame = tabFrame
    }
    
    private func configure(){
        tabBar.backgroundColor = .black
        
        //tabBar.isTranslucent = false
        
        //35 35 35
        setupBarItems()
        let tabBarItemApperance = UITabBarItem.appearance()
        tabBarItemApperance.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 10)!, NSAttributedStringKey.foregroundColor: UIColor.gray], for: .normal)
        tabBarItemApperance.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 10)!, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8588235294, green: 0.1921568627, blue: 0.4039215686, alpha: 1)], for: .selected)
    }
    
    private func setupBarItems(){
        let controller1 = MovieVC()
        controller1.tabBarItem = UITabBarItem(title: "MOVIES", image: #imageLiteral(resourceName: "movie_icon"), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        nav1.toolbar.isHidden = true
        
        let controller2 = SportVC()
        controller2.tabBarItem = UITabBarItem(title: "SPORT", image: #imageLiteral(resourceName: "sport"), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        
//        let controller3 = ProfileVC()
//        controller3.tabBarItem = UITabBarItem(title: "PROFILE", image: #imageLiteral(resourceName: "profile"), tag: 3)
//
//        let nav3 = UINavigationController(rootViewController: controller3)
//        nav3.title = ""
        
        viewControllers = [nav1, nav2]
        
    }
}

