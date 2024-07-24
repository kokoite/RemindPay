//
//  GymTabBar.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

enum TabBarItemType {
    case home
    case search
    case dashboard
    case profile
}

struct GymTabBarItem: Equatable {
    let id = UUID()
    let image, title: String
    let itemType: TabBarItemType
    let isSelected: Bool
}

protocol GymTabBarViewDelegate: AnyObject {

    func didClickItem(_ tabBarItemView: GymTabBarItemView, item: GymTabBarItem)
}

final class GymTabBarView: UIView {

    private var tabContainerView: UIView!
    private var containerView: UIStackView!
    weak var delegate: GymTabBarViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(tabItems: [GymTabBarItem]) {
        for item in tabItems {
            let view = GymTabBarItemView()
            containerView.addArrangedSubview(view)
            view.configure(item: item)
        }
        layoutIfNeeded()
    }

    func update(tabItems: [GymTabBarItem], selectedItem: GymTabBarItem) {
        containerView.arrangedSubviews.forEach { view in
            if let view = view as? GymTabBarView {
                view.delegate = nil
                view.removeFromSuperview()
            }
            containerView.removeArrangedSubview(view)
        }

        for item in tabItems {
            let itemView = GymTabBarItemView()
            itemView.delegate = self
            containerView.addArrangedSubview(itemView)
            itemView.configure(item: item)
            itemView.update(isSelected: item == selectedItem)
        }
    }


    func updateTabBarItem(selectedItem: GymTabBarItem) {
        containerView.arrangedSubviews.forEach { view in
            guard let view = view as? GymTabBarItemView else { return }
            view.updateSelectedState(using: selectedItem)
        }
    }


    private func setup() {
        setupTabBarContainer()
        setupStackView()
    }

    private func setupTabBarContainer() {
        let container = UIView()
        container.backgroundColor = .green
        tabContainerView = container
        addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: self)
    }

    private func setupStackView() {
        let container = UIStackView()
        container.backgroundColor = .yellow
        container.axis = .horizontal
        container.distribution = .fillEqually
        containerView = container
        tabContainerView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: tabContainerView)
    }
}

extension GymTabBarView: GymTabBarItemDelegate {

    func didClickItem(_ tabBarItem: GymTabBarItemView, item: GymTabBarItem) {
        delegate?.didClickItem(tabBarItem, item: item)
    }
}
