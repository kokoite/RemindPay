//
//  LibraryViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 29/07/24.
//


import UIKit

protocol LibraryViewDisplayLogic: AnyObject {
    func displayRefreshAllUsers(using vm: Library.Refresh.ViewModel)
}

final class LibraryViewController: UIViewController {

    private var containerView: UIView!
    private var headerView: GeneralHeaderView!
    private var searchContainer: UIStackView!
    private var userCollectionView: UICollectionView!
    private var createUserButton: UIImageView!
    private var users: [Library.Refresh.ViewModel.User] = []

    private var interactor: LibraryBusinessLogic?
    private var presenter: LibraryViewPresentingLogic?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    @objc func createUserClicked() {
        let controller = CreateLibraryUserViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc func handleUserAdded() {
        interactor?.fetchAllUsers(request: .init())
    }

    private func initialize() {
        let interactor = LibraryInteractor()
        let presenter = LibraryPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        self.interactor = interactor
        self.presenter = presenter
        addNotificationObservers()
    }

    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserAdded), name: Notification.Name(rawValue: LibraryConstants.userCreated), object: nil)
    }

    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: LibraryConstants.userCreated), object: nil)
    }

    private func setup() {
        setupContainerView()
        setupHeader()
        setupCollectionView()
        setupCreateUserButton()
        interactor?.fetchAllUsers(request: .init())
    }

    private func setupContainerView() {
        let container = UIView()
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
        print("deinit called \(self)")
        removeNotificationObservers()
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCell", for: indexPath) as? LibraryUserCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(using: users[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = LibraryUserDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LibraryViewController: LibraryViewDisplayLogic {

    func displayRefreshAllUsers(using vm: Library.Refresh.ViewModel) {
        switch vm.state {
        case .success(let users):
            handleSuccessResponse(using: users)
            print(users)
        case .error(let error):
            print("Error \(error.localizedDescription)")
        }
    }

    private func handleSuccessResponse(using users: [Library.Refresh.ViewModel.User]) {
        self.users =  users
        userCollectionView.reloadData()
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
