//
//  CardView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

final class CardView: UICollectionViewCell {

    private var containerView: UIView? = nil
    private var imageView: UIImageView? = nil
    private var titleView: UILabel? = nil
    private var subtitleView: UILabel? = nil
    private var startingDateView: UILabel? = nil
    private var endingDateView: UILabel? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK :-  Public methods
    func configure() {

    }

    private func setup() {
        setupContainer()
        setupImage()
    }

    private func setupContainer() {
        let container = UIView()
        contentView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: contentView)
        container.backgroundColor = UIColor(named: "CardBackground")
        container.layer.cornerRadius = 12
        container.clipsToBounds = true
        self.containerView = container
    }

    private func setupImage() {
        guard let container = containerView else { return }
        let image = UIImageView()
        container.addSubview(image)
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 100)
        let width = image.widthAnchor.constraint(equalToConstant: 100)
        let leading = image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20)
        let top = image.topAnchor.constraint(equalTo: container.topAnchor, constant: 20)
        NSLayoutConstraint.activate([height, width, leading, top])
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor

    }
}
