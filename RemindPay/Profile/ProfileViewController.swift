//
//  ProfileViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var membershipData: [MembershipViewModel] = [
        .init(backgroundColor: .systemOrange, imageName: "house.fill"),
        .init(backgroundColor: .systemPink, imageName: "graduationcap.fill"),
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
    private var containerScrollView: UIScrollView!
    private var containerView, pendingActionContainer: UIView!
    private var imageView: UIImageView!
    private var userDetailContainerView, detailContainerView: UIStackView!
    private var nameView, phoneView, emailView, pendingActionLabel: UILabel!


    // Membership Views
    private var membershipContainer: UIView!
    private var membershipLabel: UILabel!
    private var membershipCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        setupScrollView()
        setupContainer()
        setupUserDetailContainer()
        setupImageView()
        setupDetailContainer()
        setupNameView()
        setupPhoneView()
        setupEmailView()

        // Membership Details
        setupMembershipContainer()
        setupMembershipLabel()
        setupMembershipCollection()

        // Pending Action
        setupPendingActionContainer()
        setupPendingActionLabel()
        setupPendingActionTableView()
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
        containerScrollView.addSubview(container)
        containerView = container
        container.backgroundColor = .cardBackground
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupUserDetailContainer() {
        let container = UIStackView()
        container.backgroundColor = .blue
        container.spacing = 12
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        userDetailContainerView = container
        container.backgroundColor = .white
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, top, trailing])
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
    }

    private func setupDetailContainer() {
        let container = UIStackView()
        userDetailContainerView.addArrangedSubview(container)
        detailContainerView = container
        container.axis = .vertical
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        container.distribution = .equalSpacing
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.image = UIImage(named: "happyFace")
        userDetailContainerView.addArrangedSubview(image)
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 100)
        let width = image.widthAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([height, width])
    }

    private func setupNameView() {
        let name = UILabel()
        name.numberOfLines = 0
        nameView = name
        name.text = "Name: Pranjal Agarwal"
        detailContainerView.addArrangedSubview(name)
    }

    private func setupPhoneView() {
        let label = UILabel()
        label.numberOfLines = 0
        phoneView = label
        label.text = "Phone: 8209139142"
        detailContainerView.addArrangedSubview(label)
    }

    private func setupEmailView() {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Email: hehe@gmail.com"
        emailView = label
        detailContainerView.addArrangedSubview(label)
    }


    // MARK :- Membership Container
    private func setupMembershipContainer() {
        let container = UIView()
        membershipContainer = container
        containerView.addSubview(container)
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        container.backgroundColor = .white
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: userDetailContainerView.bottomAnchor, constant: 40)
        let height = container.heightAnchor.constraint(equalToConstant: 320)
        NSLayoutConstraint.activate([leading, trailing, top, height])
    }

    private func setupMembershipLabel() {
        let label = UILabel()
        membershipLabel = label
        label.text = "Subscribed services"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        membershipContainer.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: membershipContainer.leadingAnchor, constant: 20)
        let top = label.topAnchor.constraint(equalTo: membershipContainer.topAnchor, constant: 20)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupMembershipCollection() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.delegate = self
        container.dataSource = self
        container.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        container.register(MembershipCollectionViewCell.self, forCellWithReuseIdentifier: "membershipCell")
        membershipCollectionView = container
        membershipContainer.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: membershipContainer.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: membershipContainer.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: membershipLabel.bottomAnchor, constant: 12)
        let bottom = container.bottomAnchor.constraint(equalTo: membershipContainer.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    // MARK :- Pending Action Container
    private func setupPendingActionContainer() {
        let container = UIView()
        pendingActionContainer = container
        container.backgroundColor = .white
        containerView.addSubview(container)
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: membershipContainer.bottomAnchor, constant: 40)
        let height = container.heightAnchor.constraint(equalToConstant: 400)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, height, bottom])
    }

    private func setupPendingActionLabel() {
        let label = UILabel()
        pendingActionLabel = label
        label.text = "Pending Actions"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        pendingActionContainer.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: pendingActionContainer.leadingAnchor, constant: 20)
        let top = label.topAnchor.constraint(equalTo: pendingActionContainer.topAnchor, constant: 20)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPendingActionTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PendingActionTableViewCell.self, forCellReuseIdentifier: "pendingAction")
        pendingActionContainer.addSubview(tableView)
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.3
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        tableView.setTranslatesMask()
        let top = tableView.topAnchor.constraint(equalTo: pendingActionLabel.bottomAnchor, constant: 20)
        let leading = tableView.leadingAnchor.constraint(equalTo: pendingActionContainer.leadingAnchor, constant: 12)
        let trailing = tableView.trailingAnchor.constraint(equalTo: pendingActionContainer.trailingAnchor, constant: -12)
        let bottom = tableView.bottomAnchor.constraint(equalTo: pendingActionContainer.bottomAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "membershipCell", for: indexPath) as? MembershipCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(using: membershipData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width*0.37, height: view.bounds.width*0.30)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pendingAction") as? PendingActionTableViewCell else { return UITableViewCell() }
        return cell
    }
}
