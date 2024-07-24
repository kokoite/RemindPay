//
//  GymTabBarItemView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

protocol GymTabBarItemDelegate: AnyObject {
    func didClickItem(_ tabBarItem: GymTabBarItemView, item: GymTabBarItem)
}

final class GymTabBarItemView: UIView {
    private (set) var item: GymTabBarItem!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleView: UILabel!
    weak var delegate: GymTabBarItemDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    @objc func didClickItem() {
        delegate?.didClickItem(self, item: item)
    }

    func configure(item: GymTabBarItem) {
        self.item = item
        imageView.image = UIImage(systemName: item.image)
        titleView.text = item.title
    }

    func update(isSelected: Bool) {
        if(isSelected) {
            imageView.tintColor = .systemPink
            titleView.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            titleView.textColor = .gray
        } else {
            imageView.tintColor = .gray
            titleView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            titleView.textColor = .lightGray
        }
    }

    func updateSelectedState(using item: GymTabBarItem) {
        update(isSelected: item == self.item)
    }

    private func setup() {
        backgroundColor = .orange
        setupContainer()
        setupImageView()
        setupTitleView()
        setupButton()
    }

    private func setupButton() {
        let button = UIButton()
        containerView.addSubview(button)
        button.setTranslatesMask()
        button.pinToEdges(in: containerView)
        button.addTarget(self, action: #selector(didClickItem), for: .touchUpInside)
    }

    private func setupContainer() {
        let container = UIView()
        container.backgroundColor = .white
        containerView = container
        addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: self)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        containerView.addSubview(image)
        imageView.backgroundColor = .white
        image.tintColor = .gray
        image.layer.cornerRadius = 12.5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 25)
        let width = image.widthAnchor.constraint(equalToConstant: 25)
        let centerX = image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6)
        NSLayoutConstraint.activate([ height, centerX, top, width])
    }

    private func setupTitleView() {
        let label = UILabel()
        titleView = label
        containerView.addSubview(label)
        label.text = "Home"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.setTranslatesMask()
        let top = label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2)
        let centerX = label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        NSLayoutConstraint.activate([top, centerX])
    }
}
