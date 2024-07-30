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


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let grd = CAGradientLayer()
        grd.colors = [ UIColor.orange.cgColor, UIColor.systemPink.cgColor]
        grd.locations = [0, 1]
        grd.startPoint = .init(x: 0, y: 0.5)
        grd.endPoint = .init(x: 1, y: 0)
        grd.frame = view.bounds
        view.layer.insertSublayer(grd, at: 0)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func createUserClicked() {
        let controller = CreateTenantViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setup() {
        setupContainer()
        setupHeader()
        setupCollectionView()
        setupCreateUserButton()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container

        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
    }

    private func setupHeader() {
        let header = GeneralHeaderView()
        header.delegate = self
        containerView.addSubview(header)
        header.setTranslatesMask()
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let trailing = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, top, trailing])
        headerView = header
        header.configure(with: .init(iconImage: .system(name: "house"), background: nil, title: "Heyy Pranjal"))
//        header.configure(color1: .orange, color2: .black)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        container.showsVerticalScrollIndicator = false
        container.contentInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        userCollection = container
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
//        container.backgroundColor = .white
        container.dataSource = self
        container.delegate = self
        container.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "rentCell")
        containerView.addSubview(container)
        container.setTranslatesMask()
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rentCell", for: indexPath) as? UserCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width , height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TenantDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension RentViewController: GeneralHeaderDelegate {
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
