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

protocol HomeViewControllerDelegate: AnyObject {
    func didSelectMenu()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    
    private var topHeadlinesModel: [Article] = []
    private var appleNewsModel: [Article] = []
    
    public let sections = SectionType.allCases
    
    private var collectionView: UICollectionView?
    
    private var errorString: String = ""
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "NEWS"
        configureInterfaceStyle()
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        view.addSubview(collectionView)
        
        viewModel.fetchAppleNews()
        viewModel.fetchTopHeadlines()
        viewModel.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(didTapSideMenu))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        configureConstraints()
    }
    
    @objc
    private func didTapSideMenu() {
        delegate?.didSelectMenu()
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
        collectionView.isHidden = true
        collectionView.alpha = 0
        return collectionView
    }
    
    private func createHeaderLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(135)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createItemLayout() -> NSCollectionLayoutSection {
        let leftItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(220)))
        leftItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let rightItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(220)))
        rightItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(220)), subitems: [leftItem, rightItem])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
            self?.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self?.collectionView?.alpha = 1
            }
        }
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
            return appleNewsModel.count
        case .news:
            return topHeadlinesModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch sections[indexPath.section] {
        case .header:
            
            let appleNewsModel = appleNewsModel[indexPath.row]
            cell.configure(model: appleNewsModel)
        case .news:
            let newsModel = topHeadlinesModel[indexPath.row]
            cell.configure(model: newsModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: NewsTopHeadlines {
    func appleNews(_ model: [Article]) {
        self.appleNewsModel = model
        reloadCollectionView()
    }
    
    func topHeadlines(_ model: [Article]) {
        self.topHeadlinesModel = model
        reloadCollectionView()
    }
    
    func fetchError(_ error: String) {
        self.errorString = error
    }
}
