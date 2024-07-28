//
//  RentViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

import UIKit

final class RentViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    private var headerView: GeneralHeaderView!
    private var userCollection: UICollectionView!
    private var createUserButton: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemPink
        appearance.shadowColor = .systemPink
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
    }

    @objc func createUserClicked() {
        print("Create tenant clicked")
    }

    private func setup() {
        view.backgroundColor = .orange
        setupContainer()
        setupHeader()
        setupCollectionView()
        setupCreateUserButton()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .systemPink
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
    }

    private func setupHeader() {
        let header = GeneralHeaderView()
        headerView = header
        containerView.addSubview(header)
        header.setTranslatesMask()
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let height = header.heightAnchor.constraint(equalToConstant: 220)
        NSLayoutConstraint.activate([leading ,trailing, top, height])
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        userCollection = container
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.backgroundColor = .white
        container.dataSource = self
        container.delegate = self
        container.register(RentCollectionViewCell.self, forCellWithReuseIdentifier: "rentCell")
        containerView.addSubview(container)
        container.setTranslatesMask()
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20)
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([leading, top, bottom, trailing])
    }

    private func setupCreateUserButton() {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        containerView.addSubview(image)
        createUserButton = image
        image.image = UIImage(systemName: "plus.circle.fill")
        image.tintColor = .black
        image.contentMode = .scaleAspectFill
        image.setTranslatesMask()
        let trailing = image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let bottom = image.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        let height = image.heightAnchor.constraint(equalToConstant: 60)
        let width = image.widthAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([trailing, bottom, height, width])
        image.backgroundColor = .white
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector((createUserClicked)))
        image.addGestureRecognizer(gesture)
    }

    deinit {
        print("Rent view controller deinitialized")
    }
}

// CollectionView Delegates

extension RentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rentCell", for: indexPath) as? RentCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width , height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TenantDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
