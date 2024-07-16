//
//  GymViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

final class GymViewController: UIViewController {
    

    private var userCollectionView: UICollectionView!
    private var headerView: GymHeaderView!
    private var containerView: UIView!


    // MARK :- Lifecycle methods
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK :- Private functions
    private func setup() {
        view.backgroundColor = .cardBackground
        setupContainer()
    }

    private func setupHeader() {
        let header = GymHeaderView(frame: .zero)
        containerView.addSubview(header)

    }

    private func setupContainer() {
        let container = UIView()
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.backgroundColor = .white
        containerView = container
    }
}
