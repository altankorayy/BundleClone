//
//  TabBarController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let featuredVC = UINavigationController(rootViewController: FeaturedViewController())
        let contentStoreVC = UINavigationController(rootViewController: ContentStoreViewController())
        let notificationsVC = UINavigationController(rootViewController: NotificationsViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        featuredVC.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        featuredVC.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.rectangle.portrait.fill")

        contentStoreVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        contentStoreVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.fill")

        notificationsVC.tabBarItem.image = UIImage(systemName: "bell")
        notificationsVC.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        tabBar.tintColor = .label
        tabBar.barTintColor = UIColor.tabBarColor
        
        setViewControllers([homeVC, featuredVC, contentStoreVC, notificationsVC], animated: true)
    }


}

