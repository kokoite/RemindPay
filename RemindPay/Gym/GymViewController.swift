//
//  GymViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

final class GymViewController: UIViewController {
    

    private var userCollectionView: UICollectionView? = nil
    private var headerView: GymHeaderView? = nil
    private var containerView: UIView? = nil


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
