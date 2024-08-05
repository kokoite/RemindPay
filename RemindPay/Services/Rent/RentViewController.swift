//
//  RentViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

import UIKit
import SkeletonView

protocol RentDisplayLogic: AnyObject {
    func displayFetchAllTenant(using tenants: [Rent.Refresh.Response.ViewModel])
}

final class RentViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    private var headerView: GeneralHeaderView!
    private var userCollection: UICollectionView!
    private var collectionContainer: UIStackView!
    private var createUserButton: UIImageView!
    private var tenants: [Rent.Refresh.Response.ViewModel] = []
    private var interactor: RentBusinessLogic?
    private var lottieView: LottieView!
    private var loaded = false

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let grd = CAGradientLayer()
        grd.colors = [ UIColor.systemPink.cgColor, UIColor.black.cgColor]
        grd.locations = [0, 1]
        grd.startPoint = .init(x: 0, y: 0.5)
        grd.endPoint = .init(x: 1, y: 0)
        grd.frame = view.bounds
        view.layer.insertSublayer(grd, at: 0)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        userCollection.showAnimatedGradientSkeleton()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func createUserClicked() {
        let controller = CreateTenantViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func initialize() {
        let interactor = RentInteractor()
        interactor.viewController = self
        self.interactor = interactor
    }

    private func setup() {
//        view.backgroundColor = .darkCardBackground
        setupContainer()
        setupHeader()
        setupCollectionContainer()
        setupLottieView()
        setupCollectionView()
        setupCreateUserButton()
        interactor?.fetchAllTenants()
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
    }

    private func setupCollectionContainer () {
        let container = UIStackView()
        container.backgroundColor = .cardBackground
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        collectionContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        [
            container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            container.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ].forEach { const in
            const.isActive = true
        }
    }

    private func setupLottieView() {
        let lottieView = LottieView()
        self.lottieView = lottieView
        lottieView.isHidden = true
        collectionContainer.addArrangedSubview(lottieView)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.backgroundColor = .cardBackground
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        container.showsVerticalScrollIndicator = false
        container.contentInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        userCollection = container

        container.dataSource = self
        container.delegate = self
        container.register(RentUserCollectionViewCell.self, forCellWithReuseIdentifier: "rentCell")
        collectionContainer.addArrangedSubview(container)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rentCell", for: indexPath) as? RentUserCollectionViewCell else {
            return UICollectionViewCell()
        }
        if(loaded) {
            cell.configure(using: tenants[indexPath.row])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loaded ? tenants.count: 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width , height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TenantDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension RentViewController: RentDisplayLogic {
    
    func displayFetchAllTenant(using tenants: [Rent.Refresh.Response.ViewModel]) {
        loaded = true
        self.tenants = tenants
        updateLottieAndCollectionView()
    }

    private func updateLottieAndCollectionView() {
        if(tenants.isEmpty) {
            lottieView.isHidden = false
            lottieView.play()
            userCollection.isHidden = true
        } else {
            lottieView.pause()
            lottieView.isHidden = true
            userCollection.isHidden = false
            userCollection.reloadData()
        }
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
