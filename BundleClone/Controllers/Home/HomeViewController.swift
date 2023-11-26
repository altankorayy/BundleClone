//
//  HomeViewController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

enum SectionType: CaseIterable {
    case header
    case news
}


class HomeViewController: UIViewController {
    
    public let sections = SectionType.allCases
    
    private var collectionView: UICollectionView?
    
    private var model: [Article] = []
    private var errorString: String = ""
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "NEWS"
        configureInterfaceStyle()
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        view.addSubview(collectionView)
        
        viewModel.apiRequest = APIRequest()
        viewModel.delegate = self
        viewModel.fetchTopHeadlines()
        
        configureConstraints()
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }
    
    private func createHeaderLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createItemLayout() -> NSCollectionLayoutSection {
        let leftItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200)))
        leftItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let rightItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200)))
        rightItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [leftItem, rightItem])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }


    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        switch sections[sectionIndex] {
        case .header:
            return createHeaderLayout()
        case .news:
            return createItemLayout()
        }
    }
    
    private func configureInterfaceStyle() {
        if UIScreen.darkMode {
            view.backgroundColor = UIColor.bundleColor
        } else {
            view.backgroundColor = .white
        }
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .header:
            return 20
        case .news:
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch sections[indexPath.section] {
        case .header:
            break
        case .news:
            let newsModel = model[indexPath.row]
            cell.configure(model: newsModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: NewsTopHeadlines {
    func topHeadlines(_ model: [Article]) {
        self.model = model
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    func fetchError(_ error: String) {
        self.errorString = error
    }
}
