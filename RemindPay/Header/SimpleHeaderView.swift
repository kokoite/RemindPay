//
//  SimpleHeaderView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit

struct SimpleHeaderViewModel {
    let name: String
    let profileImage: UIImage
}

final class SimpleHeaderView: UIView {

    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleView: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(using vm: SimpleHeaderViewModel) {
        titleView.text = "Welcome back,\(vm.name)"
        imageView.image = vm.profileImage
    }

    private func setup() {
        setupContainer()
        setupImageView()
        setupTitle()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .white
        addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: self)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.backgroundColor = .gray
        containerView.addSubview(image)
        image.setTranslatesMask()
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 12)
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12)
        let height = image.heightAnchor.constraint(equalToConstant: 60)
        let width = image.widthAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([height, width, top, leading])
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
    }

    private func setupTitle() {
        let label = UILabel()
        titleView = label
        label.numberOfLines = 0
        label.text = "Welcome back, Pranjal"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12)
        let centerY = label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, centerY, trailing])
    }
}
