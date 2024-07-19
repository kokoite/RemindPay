//
//  GymViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

protocol GymDisplayLogic: AnyObject {

}

final class GymViewController: UIViewController, GymDisplayLogic {

    private var collectionContainerView: UIView!
    private var userCollectionView: UICollectionView!
    private var headerView: GymHeaderView!
    private var containerView: UIView!
    private var interactor: GymInteractor?
    private var router: GymRouter?
    private var presenter: GymPresenter?


    // MARK :- Lifecycle methods
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupInitializers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK :- Private functions

    private func setupInitializers() {
        let router = GymRouter()
        let interactor = GymInteractor()
        let presenter = GymPresenter()
        router.dataStore = interactor
        router.viewController = self
        interactor.presenter = presenter
        presenter.viewController = self
        self.presenter = presenter
        self.interactor = interactor
        self.router = router
    }

    private func setup() {
        view.backgroundColor = .cardBackground
        setupContainer()
        setupHeader()
        setupCollectionContainer()
        setupUserCollectionView()
    }

    private func setupHeader() {
        let header = GymHeaderView(frame: .zero)
        containerView.addSubview(header)
        header.setTranslatesMask()
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let trailing = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let height = header.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([leading, top, trailing, height])
        headerView = header
    }

    private func setupContainer() {
        let container = UIView()
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.backgroundColor = .red
        containerView = container
    }

    private func setupCollectionContainer() {
        let container = UIView()
        collectionContainerView = container
        containerView.addSubview(container)
        container.layer.cornerRadius = 30
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        container.backgroundColor = .white
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
    }

    private func setupUserCollectionView() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        userCollectionView = collection
        containerView.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.register(GymCardView.self, forCellWithReuseIdentifier: "gymCell")
        collection.clipsToBounds = true
        collection.setTranslatesMask()
        let leading = collection.leadingAnchor.constraint(equalTo: collectionContainerView.leadingAnchor, constant: 12)
        let trailing = collection.trailingAnchor.constraint(equalTo: collectionContainerView.trailingAnchor, constant: -12)
        let top = collection.topAnchor.constraint(equalTo: collectionContainerView.topAnchor, constant: 15)
        let bottom = collection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
    }
}


extension GymViewController: UICollectionViewDelegate {


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToGymUserDetailPage()
    }


}

extension GymViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gymCell", for: indexPath) as? GymCardView ?? UICollectionViewCell()
        return cell
    }

}


extension GymViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width, height: 200)
    }
}
