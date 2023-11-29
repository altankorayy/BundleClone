//
//  FeaturedTableViewHeader.swift
//  BundleClone
//
//  Created by Altan on 13.11.2023.
//

import UIKit

class FeaturedTableViewHeader: UIView {
    
    private let storyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FeaturedHeaderCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedHeaderCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.bundleColor
        collectionView.alpha = 0
        return collectionView
    }()
    
    private var model: [Article] = []
    
    private let viewModel = FeaturedTableViewHeaderViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.bundleColor
        
        addSubview(storyCollectionView)
        
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        
        viewModel.fetchStoryNews()
        viewModel.delegate = self
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.storyCollectionView.reloadData()
            
            UIView.animate(withDuration: 0.4) {
                self?.storyCollectionView.alpha = 1
            }
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            storyCollectionView.topAnchor.constraint(equalTo: topAnchor),
            storyCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            storyCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            storyCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension FeaturedTableViewHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedHeaderCollectionViewCell.identifier, for: indexPath) as? FeaturedHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        let storyModel = model[indexPath.row]
        cell.configure(with: storyModel)
        return cell
    }
}

extension FeaturedTableViewHeader: FeaturedTableViewHeaderModel {
    func fetchStoryNews(_ model: [Article]) {
        self.model = model
        reloadCollectionView()
    }
}
