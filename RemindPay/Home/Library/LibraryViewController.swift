//
//  LibraryViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 29/07/24.
//

import UIKit

final class LibraryViewController: UIViewController {

    private var containerView: UIView!
    private var headerView: GeneralHeaderView!
    private var searchContainer: UIStackView!
    private var userCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let grd = CAGradientLayer()
        grd.colors = [ UIColor.purple.cgColor, UIColor.blue.cgColor]
        grd.locations = [0, 1]
        grd.startPoint = .init(x: 0.5, y: 0.3)
        grd.endPoint = .init(x: 1, y: 0)
        grd.frame = view.bounds
        view.layer.insertSublayer(grd, at: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    private func setup() {
        setupContainerView()
        setupHeader()
        setupCollectionView()
    }

    private func setupContainerView() {
        let container = UIView()
//        container.backgroundColor = .systemOrange
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)

    }

    private func setupHeader() {
        let header = GeneralHeaderView()
        containerView.addSubview(header)
        header.delegate = self
        headerView = header
        header.setTranslatesMask()
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
        header.configure(with: .init(iconImage: .system(name: "book"), background: nil, title: "Heyy Pranjal"))
//        header.configure(color1: .black, color2: .blue)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        userCollectionView = container
        container.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "libraryCell")
        container.dataSource = self
        container.delegate = self
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.showsVerticalScrollIndicator = false
        container.contentInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumLineSpacing = 12
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailng = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailng, top, bottom])
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCell", for: indexPath) as? UserCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = LibraryUserDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LibraryViewController: GeneralHeaderDelegate {
    func didClickProfileImage() {

    }

    func didClickOnSearchButton(text: String) {

    }

    func didClickOnFilter() {

    }

    func onSearchViewTextChange(text: String) {

    }

    func didClickOnBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
