//
//  CarouselCell.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 18/07/24.
//

import UIKit

final class CarouselCell: UICollectionViewCell {

    private var containerView: UIView!
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(using image: UIImage?) {
        imageView.image = image
    }

    private func setup() {
        setupContainer()
        setupImageView()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        contentView.addSubview(container)
        container.setTranslatesMask()
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        container.pinToEdges(in: contentView)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        containerView.addSubview(image)
        image.setTranslatesMask()
        [
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ].forEach { const in
            const.isActive = true
        }
        image.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "happyFace")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
    }
}
