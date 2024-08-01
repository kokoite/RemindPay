//
//  DropDownView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import UIKit

final class DropDownView: UIView {
    
    private var titleView: UILabel!
    private var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let container = UIStackView()
        addSubview(container)
        container.backgroundColor = .orange
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 12)
        container.setTranslatesMask()
        [
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].forEach { const in
            const.isActive = true
        }
        container.spacing = 6
        let label = getLabel()
        let image = getImageView()
        container.addArrangedSubview(label)
        container.addArrangedSubview(image)
    }

    private func getLabel() -> UILabel {
        let label = UILabel()
        label.text = "Rent"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }

    private func getImageView() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.down")
        image.contentMode = .scaleAspectFit
        image.setTranslatesMask()
        [
            image.heightAnchor.constraint(equalToConstant: 20),
            image.widthAnchor.constraint(equalToConstant: 20)
        ].forEach { cons in
            cons.isActive = true
        }
        return image
    }
}
