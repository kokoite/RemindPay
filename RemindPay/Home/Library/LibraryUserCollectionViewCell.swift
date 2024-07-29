//
//  LibraryUserCollectionViewCell.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 29/07/24.
//

import UIKit

final class LibraryUserCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView!
    private var imageView: UIImageView!
    private var detailContainerView: UIStackView!
    private var nameView, phoneView, emailView: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 12
        clipsToBounds = true
        setupContainer()
        setupImageView()
        setupDetailContainer()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .cardBackground
        contentView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: contentView)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "happyFace")
        containerView.addSubview(image)
        image.setTranslatesMask()
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let top = image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        let bottom = image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        let width = image.widthAnchor.constraint(equalToConstant: 120)
        NSLayoutConstraint.activate([leading, top, bottom, width])
    }

    private func setupDetailContainer() {
        let container = UIStackView()
        container.backgroundColor = .cardBackground
        container.axis = .vertical
        container.spacing = 12
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        detailContainerView = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let centerY = container.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, trailing, centerY])
        let name = getLabel(text: "Pranjal")
        let phone = getLabel(text: "+91 820 9131942")
        let email = getLabel(text: "pranjal@gmail.com")
        container.addArrangedSubview(name)
        container.addArrangedSubview(phone)
        container.addArrangedSubview(email)
    }

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }
}
