//
//  HomeViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

final class HomeViewController: UIViewController {
    private weak var containerScrollView: UIScrollView!
    private weak var containerView: UIView!
    private weak var headerView: UIView!
    private weak var serviceContainer, subscribedContainer: UIStackView!
    private weak var serviceLabel, subscribedLabel: UILabel!
    private weak var serviceCollection, subscribedCollection: UICollectionView!

    private var membershipData: [MembershipCellData] = [
        .init(backgroundColor: .systemOrange, imageName: "house.fill"),
        .init(backgroundColor: .systemPink, imageName: "cart.fill"),
        .init(backgroundColor: .systemGreen, imageName: "dumbbell.fill"),
        .init(backgroundColor: .systemBlue, imageName: "book.fill"),
        .init(backgroundColor: .systemYellow, imageName: "house.fill"),
        .init(backgroundColor: .systemRed, imageName: "house.fill"),
        .init(backgroundColor: .systemOrange, imageName: "dumbbell.fill"),
        .init(backgroundColor: .systemPink, imageName: "house.fill"),
        .init(backgroundColor: .systemGreen, imageName: "house.fill"),
        .init(backgroundColor: .systemBlue, imageName: "house.fill"),
        .init(backgroundColor: .systemYellow, imageName: "house.fill"),
        .init(backgroundColor: .systemRed, imageName: "house.fill"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        setupScrollView()
        setupContainer()
        setupHeader()
        setupServiceContainer()
        setupServiceLabel()
        setupServiceCollection()

        setupSubscribedContainer()
        setupSubscribedLabel()
        setupSubscribedCollection()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .cardBackground
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        let top = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let leading = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

    private func setupContainer() {
        let container = UIView()
        container.backgroundColor = .cardBackground
        containerView = container
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupHeader() {
        let header = HeaderView()
        headerView = header
        header.layer.cornerRadius = 20
        header.clipsToBounds = true
        containerView.addSubview(header)
        header.setTranslatesMask()
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let trailng = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let height = header.heightAnchor.constraint(equalToConstant: 80)
        NSLayoutConstraint.activate([leading, top, trailng, height])
    }

    private func setupServiceContainer() {
        let container = UIStackView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.axis = .vertical
        container.spacing = 12
        container.clipsToBounds = true
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        serviceContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupServiceLabel() {
        let label = UILabel()
        serviceLabel = label
        label.text = "Services we provide"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        serviceContainer.addArrangedSubview(label)
    }

    private func setupServiceCollection() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.delegate = self
        container.dataSource = self
        container.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        container.register(MembershipCollectionViewCell.self, forCellWithReuseIdentifier: "membershipCell")
        serviceCollection = container
        serviceContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        let height = container.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([height])
    }

    private func setupNoAvailableServices() {

    }

    private func setupSubscribedContainer() {
        let container = UIStackView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.axis = .vertical
        container.spacing = 12
        container.clipsToBounds = true
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        subscribedContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: serviceContainer.bottomAnchor, constant: 40)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    private func setupSubscribedLabel() {
        let label = UILabel()
        subscribedLabel = label
        label.text = "Subscribed Services"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        subscribedContainer.addArrangedSubview(label)
    }

    private func setupSubscribedCollection() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.delegate = self
        container.dataSource = self
        container.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        container.register(MembershipCollectionViewCell.self, forCellWithReuseIdentifier: "membershipCell")
        subscribedCollection = container
        subscribedContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        let height = container.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([height])
    }

    deinit {
        print("Deinit called")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "membershipCell", for: indexPath) as? MembershipCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(using: membershipData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width*0.35, height: view.bounds.width*0.3)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = GymViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
