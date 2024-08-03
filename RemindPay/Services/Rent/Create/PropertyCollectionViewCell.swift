//
//  AddPropertyView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 02/08/24.
//

import UIKit

final class PropertyCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView!
    private var removeImage: UIImageView!
    private var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setup()
        setupRemoveImage()
        setupPropertyImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    func configure(using image: UIImage) {
        imageView.image = image
    }

    private func setup() {
        let container = UIView()
//        container.backgroundColor = .systemPink
        containerView = container
        contentView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: contentView)
    }

    private func setupPropertyImageView() {
        let image = UIImageView()
        imageView = image
        imageView.clipsToBounds = true
        image.contentMode = .scaleToFill
        containerView.addSubview(image)
        image.setTranslatesMask()
        [
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            image.topAnchor.constraint(equalTo: removeImage.bottomAnchor),
            image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ].forEach { const in
            const.isActive = true
        }
        image.layer.cornerRadius = 6
    }

    private func setupRemoveImage() {
        let image = UIImageView()
        removeImage = image
        image.tintColor = .black
        image.layer.cornerRadius = 12.5
        image.clipsToBounds = true
        image.image = UIImage(systemName: "multiply")
        containerView.addSubview(image)
        image.setTranslatesMask()
        [
            image.topAnchor.constraint(equalTo: containerView.topAnchor),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2)
        ].forEach { const in
            const.isActive = true
        }
    }
}
