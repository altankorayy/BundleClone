//
//  HomeVCNavigationBarView.swift
//  BundleClone
//
//  Created by Altan on 17.12.2023.
//

import UIKit

class HomeVCNavigationBarView: UIView {
    
    private let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeVCNavigationBarViewCollectionViewCell.self, forCellWithReuseIdentifier: HomeVCNavigationBarViewCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        addSubviews(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension HomeVCNavigationBarView: UICollectionViewDelegate, UICollectionViewDataSource, UINavigationBarDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVCNavigationBarViewCollectionViewCell.identifier, for: indexPath) as? HomeVCNavigationBarViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        let titles = ["All", "Sports", "Gaming", "Tech", "Politics", "Business", "Fashion", "Science", "News", "Cinema", "Arts"]
        cell.setTitle(titles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIDevice.isiPhone ? 65 : 85, height: 50)
    }
}
