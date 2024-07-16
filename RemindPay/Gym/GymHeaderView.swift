//
//  GymHeaderView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

final class GymHeaderView: UIView {

    private var containerView: UIView!
    private var imageView: UIView!
    private var titleView: UILabel!
    private var searchView: SearchView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure() {

    }



    // MARK :- Private functions

    private func setup() {
        setupContainer()
        setupImage()
        setupTitle()
        setupIcon()
        setupSearch()
    }

    private func setupImage() {
        let image = UIImageView()
        imageView = image
        containerView.addSubview(image)
        image.setTranslatesMask()
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor)
        let height = image.heightAnchor.constraint(equalToConstant: 60)
        let width = image.widthAnchor.constraint(equalToConstant: 60)
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.backgroundColor = .cardBackground
        NSLayoutConstraint.activate([leading, top, height, width])
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        addSubview(container)
        container.setTranslatesMask()
        container.backgroundColor = .red
        container.pinToEdges(in: self)
    }

    private func setupTitle() {
        let title = UILabel()
        titleView = title
        title.text = "Heyy, Pranjal"
        title.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        containerView.addSubview(title)
        title.setTranslatesMask()
        let leading = title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        let centerY = title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        NSLayoutConstraint.activate([leading, centerY])
    }

    private func setupIcon() {
        let imageView = UIImageView()
        containerView.addSubview(imageView)
        imageView.setTranslatesMask()
        let leading = imageView.leadingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor, constant: 12)
        let centerY = imageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        let trailing = imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let height = imageView.heightAnchor.constraint(equalToConstant: 40)
        let width = imageView.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([leading, centerY, trailing, height, width])
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "dumbbell")
    }

    private func setupSearch() {
        let search = SearchView()
        searchView = search
        containerView.addSubview(search)
        search.setTranslatesMask()
        let leading = search.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10)
        let trailling = search.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        let top = search.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        let height = search.heightAnchor.constraint(equalToConstant: 45)
        NSLayoutConstraint.activate([leading, trailling, top, height])
    }
}
