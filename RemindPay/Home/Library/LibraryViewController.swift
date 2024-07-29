//
//  LibraryViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 29/07/24.
//

import UIKit

final class LibraryViewController: UIViewController {

    private var containerView: UIView!
    private var headerView: SimpleHeaderView!
    private var searchContainer: UIStackView!
    private var userCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .cardBackground
        appearance.shadowColor = .cardBackground
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }

    private func setup() {
        setupContainerView()
        setupHeader()
        setupSearchView()
        setupCollectionView()
    }

    private func setupContainerView() {
        let container = UIView()
        container.backgroundColor = .cardBackground
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)

    }

    private func setupHeader() {
        let header = SimpleHeaderView()
        containerView.addSubview(header)
        headerView = header
        header.clipsToBounds = true
        header.layer.cornerRadius = 20
        header.setTranslatesMask()
        let top = header.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 12)
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let height = header.heightAnchor.constraint(equalToConstant: 80)
        NSLayoutConstraint.activate([leading, trailing, height, top])
    }

    private func setupSearchView() {
        let container = UIStackView()
        searchContainer = container
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.backgroundColor = .white
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 6, left: 0, bottom: 6, right: 0)
        container.backgroundColor = .white
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([leading, trailing, top])
        let search = SearchView()
        container.addArrangedSubview(search)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        userCollectionView = container
        container.register(LibraryUserCollectionViewCell.self, forCellWithReuseIdentifier: "libraryCell")
        container.dataSource = self
        container.delegate = self
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.showsVerticalScrollIndicator = false
        layout.sectionInset = .init(top: 20, left: 6, bottom: 12, right: 6)
        layout.minimumLineSpacing = 15
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailng = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 20)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailng, top, bottom])
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCell", for: indexPath) as? LibraryUserCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width * 0.9, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = LibraryUserDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
