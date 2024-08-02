//
//  GymTabBarController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

final class GymTabBarController: UIViewController {

    private var containerView: UIView!
    private var tabBar: GymTabBarView!
    private var selectedItem: GymTabBarItem!
    private var homeViewController: HomeViewController!
    private var searchViewController: UIViewController!
    private var dashboardViewController: DashboardViewController!
    private var profileViewController: ProfileViewController!


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        homeViewController = HomeViewController()
        searchViewController = SearchViewController() 
        dashboardViewController = DashboardViewController()
        profileViewController = ProfileViewController()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reloadContainerView(oldController: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // remove that controller
    }
//
//    override var childForStatusBarStyle: UIViewController? {
//        children.first
//    }

    private func setup() {
        setupTabBarView()
        setupContainer()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .white
        view.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
    }

    private func setupTabBarView() {
        let container = GymTabBarView()
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = .init(width: 4, height: 4)
        container.layer.shadowOpacity = 1
        container.layer.shadowRadius = 20
        tabBar = container
        container.delegate = self
        container.backgroundColor = .white
        view.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let height = container.heightAnchor.constraint(equalToConstant: 70)
        NSLayoutConstraint.activate([leading, trailing, bottom, height])
        configureTabBarView()
    }

    private func configureTabBarView() {
        let homeItem = GymTabBarItem(image: "house",
                                     title: "Home",
                                     itemType: .home,
                                     isSelected: true)
//        let searchItem = GymTabBarItem(image: "magnifyingglass", title: "Search", itemType: .search, isSelected: false)
        let dashboardItem = GymTabBarItem(image: "indianrupeesign", title: "Dashboard", itemType: .dashboard, isSelected: false)
        let profileItem = GymTabBarItem(image: "person.fill", title: "Profile", itemType: .profile, isSelected: false)
        selectedItem = homeItem
        tabBar.update(tabItems: [homeItem, dashboardItem, profileItem], selectedItem: homeItem)
    }

    private func reloadContainerView(oldController: UIViewController?) {
        oldController?.removeFromParent()
        oldController?.view.removeFromSuperview()
        oldController?.didMove(toParent: nil)

        let controller = switch(selectedItem.itemType) {
        case .home:
            homeViewController
        case .search:
            searchViewController
        case .dashboard:
            dashboardViewController
        case .profile:
            profileViewController
        }
        guard let controller else { return }
        addChild(controller)
        controller.view.frame = containerView.frame
        containerView.addSubview(controller.view)
        controller.didMove(toParent: self)
        tabBar.updateTabBarItem(selectedItem: selectedItem)
    }
}

extension GymTabBarController: GymTabBarViewDelegate {

    func didClickItem(_ tabBarItemView: GymTabBarItemView, item: GymTabBarItem) {

        guard item != selectedItem else {
            // Clicking on selected tab
            return
        }
        let controller = switch(selectedItem.itemType) {
        case .home:
            homeViewController
        case .profile:
            profileViewController
        case .search:
            searchViewController
        case .dashboard:
            dashboardViewController
        }
        guard let controller else { return }
        selectedItem = item
        reloadContainerView(oldController: controller)
    }
}
