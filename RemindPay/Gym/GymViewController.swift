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
    private var userCollectionView: UICollectionView!
    private var headerView: GymHeaderView!
    private var createUserButton: UIImageView!
    private var containerView: UIView!
    private var interactor: GymInteractor?
    private var router: GymRouter?
    private var presenter: GymPresenter?
    private var userCollectionTopConstraint: NSLayoutConstraint?
    private var userCollectionSuperTopConstraint: NSLayoutConstraint?
    private var headerHeightConstraint: NSLayoutConstraint?
    private var shouldUpdateInset = true


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

    @objc func createUserClicked() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.createUserButton.tintColor = .gray
        } completion: { [weak self] _ in
            self?.router?.routeToCreateUserPage()
            self?.createUserButton.tintColor = .black
        }
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
        setupUserCollectionView()
        setupCreateUserButton()
    }

    private func setupHeader() {
        let header = GymHeaderView()
        header.delegate = self
        containerView.addSubview(header)
        header.setTranslatesMask()
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let trailing = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let bottom = header.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 150)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
        headerView = header
    }

    private func setupContainer() {
        let container = UIView()
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.backgroundColor = .systemPink
        containerView = container
    }

    private func setupUserCollectionView() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        userCollectionView = collection
        containerView.addSubview(collection)
        collection.layer.cornerRadius = 30
        collection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.register(GymCardView.self, forCellWithReuseIdentifier: "gymCell")
        collection.clipsToBounds = true
        collection.setTranslatesMask()
        let leading = collection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = collection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let top = collection.topAnchor.constraint(equalTo: headerView.bottomAnchor)
        let bottom = collection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, bottom, top])
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

extension GymViewController: GymHeaderDelegate {

    func didClickProfileImage() {
        router?.routeToProfilePage()
    }

    func didClickOnFilter() {
        router?.showFilterBottomSheet()
    }

    func didClickOnSearchButton(text: String) {
        print(text)
    }

    func onSearchViewTextChange(text: String) {
        print(text)
    }
}


extension GymViewController: FilterBottomSheetDelegate {
    func didClickOnButton(with action: FilterAction) {
        print(action)
    }
    


}
