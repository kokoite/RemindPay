//
//  GymViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

protocol GymDisplayLogic: AnyObject {
    func displayRefresh(respnose: Gym.Refresh.Response)
}

final class GymViewController: UIViewController{
    private var userCollectionView: UICollectionView!
    private var headerView: GeneralHeaderView!
    private var createUserButton: UIImageView!
    private var containerView: UIView!
    private var interactor: GymInteractor?
    private var router: GymRouter?
    private var presenter: GymPresenter?
    private var users: [Gym.Refresh.User] = []


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


    @objc func createUserClicked() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.createUserButton.tintColor = .gray
        } completion: { [weak self] _ in
            self?.router?.routeToCreateUserPage()
            self?.createUserButton.tintColor = .black
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router?.viewController = self
        presenter?.viewController = self
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        router?.viewController = nil
        presenter?.viewController = nil
        print("view controller will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK :- Private functions

    private func setupInitializers() {
        let router = GymRouter()
        let interactor = GymInteractor()
        let presenter = GymPresenter()
        router.dataStore = interactor
        router.viewController = self
        interactor.viewController = self
        presenter.viewController = self
        self.presenter = presenter
        self.interactor = interactor
        self.router = router
    }

    private func setup() {
        view.backgroundColor = .white
        setupContainer()
        setupHeader()
        setupUserCollectionView()
        setupCreateUserButton()
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
        header.configure(with: .init(iconImage: .system(name: "dumbbell"), background: nil, title: "Heyy Pranjal"))
        headerView = header
    }

    private func setupContainer() {
        let container = UIView()
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
//        container.backgroundColor = .systemPink
        containerView = container
    }

    private func setupUserCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 12
        userCollectionView = collection
        collection.backgroundColor = .white
        containerView.addSubview(collection)
        collection.layer.cornerRadius = 30
        collection.contentInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        collection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "gymCell")
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

    deinit {
        interactor = nil
        router = nil
        presenter = nil
        print("deinit called \(self)")
    }
}


extension GymViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToGymUserDetailPage()
    }


}

extension GymViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gymCell", for: indexPath) as? UserCollectionViewCell else {
            return UICollectionViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(using: .init(name: user.name, phone: user.phone, expiryDate: user.expiryDate, profileImage: user.profileImage))
        return cell
    }
}

extension GymViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width, height: 160)
    }
}

extension GymViewController: GeneralHeaderDelegate {
    
    func didClickOnBackButton() {
        navigationController?.popViewController(animated: true)
    }
    

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


extension GymViewController: GymDisplayLogic {

    func displayRefresh(respnose: Gym.Refresh.Response) {

        switch respnose.state {
        case .success(let viewModel):
            users = viewModel.users
            userCollectionView.reloadData()
        case .error(let error):
            print("Error \(error.localizedDescription)")
            // show error bottom sheet
        }
    }
}
