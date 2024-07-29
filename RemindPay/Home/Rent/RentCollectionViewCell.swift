//
//  RentCollectionViewCell.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

import UIKit

final class RentCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView!
    private var imageView: UIImageView!
    private var detailContainerView: UIStackView!
    private var nameView, phoneView, rentDateLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.backgroundColor = .white
        setupContainer()
        setupImageView()
        setupDetailContainer()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.backgroundColor = .cardBackground
        contentView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        let trailing = container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        let top = container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        let bottom = container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.image = UIImage(named: "happyFace")
        containerView.addSubview(image)
        image.setTranslatesMask()
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        let height = image.heightAnchor.constraint(equalToConstant: 150)
        let centerY = image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12)
        image.layer.cornerRadius = 30
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
//        image.backgroundColor = .lightGray
        NSLayoutConstraint.activate([leading, centerY, height, width])
    }

    private func setupDetailContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        detailContainerView = container
        container.setTranslatesMask()
        containerView.addSubview(container)
        let leading = container.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12)
        let centerY = container.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, centerY, trailing])
        let name = getLabel(text: "Pranjal")
        let phone = getLabel(text: "+91 820 9131942")
        let address = getLabel(text: "D-406 Jagadamba Nagar Ajmer road")
        address.numberOfLines = 0
        container.addArrangedSubview(name)
        container.addArrangedSubview(phone)
        container.addArrangedSubview(address)
    }

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }
}
