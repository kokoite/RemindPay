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

    func configure() {

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
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        container.pinToSafeEdges(in: contentView)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        containerView.addSubview(image)
        image.setTranslatesMask()
        image.pinToEdges(in: containerView)
        image.layer.cornerRadius = 20
        imageView.image = UIImage(named: "happyFace")
        image.contentMode = .scaleAspectFill
    }
}
