//
//  MembershipCollectionViewCell.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit


struct MembershipCellData {
    let backgroundColor: UIColor
    let imageName: String
}

final class MembershipCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    private var containerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(using data: MembershipCellData) {
        containerView.backgroundColor = data.backgroundColor
        imageView.image = UIImage(systemName: data.imageName)
    }

    private func setup() {
        setupContainer()
        setupImageView()
        clipsToBounds = true
        layer.cornerRadius = 12
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        contentView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: contentView)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        containerView.addSubview(image)
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 100)
        let width = image.widthAnchor.constraint(equalToConstant: 100)
        let centerX = image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let centerY = image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([height, width, centerX, centerY])
    }
}
