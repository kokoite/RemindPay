//
//  TabBarController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .systemPink
        let homeImage = UIImage(systemName: "house.circle.fill")
        let homeTabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        homeTabBarItem.largeContentSizeImage = homeImage

        let homeController = HomeViewController()
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem = homeTabBarItem

        let searchImage = UIImage(systemName: "magnifyingglass.circle.fill")
        let searchTabBarItem = UITabBarItem(title: "Search", image: searchImage, tag: 1)
        let searchController = ViewController()
        let searchNavController = UINavigationController(rootViewController: searchController)
        searchNavController.tabBarItem = searchTabBarItem


        let dashboardImage = UIImage(systemName: "indianrupeesign.circle.fill")
        let dashboardTabBarItem = UITabBarItem(title: "Dashboard", image: dashboardImage, tag: 2)

        let dashboardController = DashboardViewController()
        let dashboardNavController = UINavigationController(rootViewController: dashboardController)
        dashboardNavController.tabBarItem = dashboardTabBarItem

        let profileImage = UIImage(systemName: "person.circle.fill")
        let profileTabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 3)
        let profileController = ProfileViewController()
        let profileNavContrller = UINavigationController(rootViewController: profileController)
        profileNavContrller.tabBarItem = profileTabBarItem
        viewControllers = [homeNavController, searchNavController, dashboardNavController, profileNavContrller]
    }


}
