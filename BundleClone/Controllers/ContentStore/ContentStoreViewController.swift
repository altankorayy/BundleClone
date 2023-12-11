//
//  ContentStoreViewController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class ContentStoreViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let searchResultsVC = SearchResultsViewController()
        let searchResultsNav = UINavigationController(rootViewController: searchResultsVC)
        let searchController = UISearchController(searchResultsController: searchResultsNav)
        searchController.searchBar.placeholder = "Search for News, Sources or Topics"
        return searchController
    }()
        
    private let viewModel = ContentStoreViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "CONTENT STORE"
        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        
        configureNavigationBar()
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    }

}

extension ContentStoreViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 1 else { return }
        
        viewModel.queryString = query
        viewModel.search()
    }
}
