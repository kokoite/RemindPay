//
//  CarouseView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 18/07/24.
//

import UIKit


protocol CarouselViewDelegate: AnyObject {
    func didSelectItemAtIndexPath(indexPath: IndexPath)
    func didScrollToItemAtIndexPath(indexPath: IndexPath)
    func numberOfItemsInCarousel() -> Int
}

final class CarouselView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    private var containerView: UIView!
    private var pageControlView: UIPageControl!
    weak var delegate: CarouselViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfItemsInCarousel() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as? CarouselCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item clicked in carousel at \(indexPath)")
        delegate?.didSelectItemAtIndexPath(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width, height: frame.height - 24)
    }

    func configure() {

    }

    private func setup() {
        setupContainer()
        setupCollectionView()
        setupPageControlView()
    }


    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .white
        addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: self)
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collectionView = collection
        containerView.addSubview(collection)
        collection.setTranslatesMask()
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        let top = collection.topAnchor.constraint(equalTo: containerView.topAnchor)
        let leading = collection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = collection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, top, trailing])
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: "carouselCell")
    }

    private func setupPageControlView() {
        let pageControl = UIPageControl()
        pageControlView = pageControl
        containerView.addSubview(pageControl)
        pageControl.setTranslatesMask()
        let centerX = pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        let top = pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12)
        let height = pageControl.heightAnchor.constraint(equalToConstant: 12)
        let bottom = pageControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([centerX, top, bottom, height])
        pageControl.numberOfPages = 10
        pageControl.currentPageIndicatorTintColor = .systemPink
        pageControl.pageIndicatorTintColor = .systemGray
    }
}
