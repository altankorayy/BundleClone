//
//  SideMenuDetailViewController.swift
//  BundleClone
//
//  Created by Altan on 9.12.2023.
//

import UIKit

class SideMenuDetailViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var model: [Article] = []
    
    private var refreshControl: UIRefreshControl?
        
    init(model: [Article]) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        view.addSubview(collectionView)
        
        navigationController?.navigationBar.tintColor = .label
        
        configureRefreshControl()
                        
        configureConstraints()
    }
    
    private func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.collectionView?.alwaysBounceVertical = true
        self.refreshControl?.addTarget(self, action: #selector(didLoadData), for: .valueChanged)
        self.collectionView?.addSubview(refreshControl!)
    }
    
    @objc
    private func didLoadData() {
        self.refreshControl?.beginRefreshing()
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }
    
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createItemLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }
    
    private func createItemLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(UIDevice.isiPhone ? 0.5 : 0.25), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isiPhone ? 230 : 350)), subitems: UIDevice.isiPhone ? [item, item] : [item, item, item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension SideMenuDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let searchModel = model[indexPath.row]
        cell.configure(model: searchModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        DispatchQueue.main.async {
            let detailVC = DetailsViewController()
            let selectedModel = self.model[indexPath.row]
            detailVC.configure(with: selectedModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
