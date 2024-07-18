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
        return frame.size
    }

    func configure() {

    }

    private func setup() {
        setupContainer()
        setupCollectionView()
    }


    private func setupContainer() {
        let container = UIView()
        containerView = container
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
        layout.minimumLineSpacing = 20
        collection.showsHorizontalScrollIndicator = false
        collectionView = collection
        containerView.addSubview(collection)
        collection.setTranslatesMask()
        collection.dataSource = self
        collection.delegate = self
        collection.pinToEdges(in: containerView)
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: "carouselCell")
    }
}
