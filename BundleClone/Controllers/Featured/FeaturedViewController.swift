//
//  FeaturedViewController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    private var tableView: UITableView?
    private let viewModel = FeaturedViewModel()
    
    private var model: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "FEATURED"
        configureInterfaceStyle()
        
        let tableView = createTableView()
        self.tableView = tableView
        view.addSubview(tableView)
        
        viewModel.fetchFeaturedNews()
        viewModel.delegate = self
                
        configureConstraints()
        
        setHeaderView()
        configureNavigationBar()
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeaturedTableViewCell.self, forCellReuseIdentifier: FeaturedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.alpha = 0
        tableView.separatorStyle = .none
        return tableView
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
            
            UIView.animate(withDuration: 0.4) {
                self?.tableView?.alpha = 1
            }
        }
    }
    
    private func configureInterfaceStyle() {
        if UIScreen.darkMode {
            view.backgroundColor = UIColor.bundleColor
        } else {
            view.backgroundColor = .white
        }
    }
    
    private func setHeaderView() {
        let header = FeaturedTableViewHeader()
        header.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 120)
        
        self.tableView?.tableHeaderView = header
        
        header.delegate = self
    }
    
    private func configureConstraints() {
        guard let tableView = tableView else { return }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedTableViewCell.identifier, for: indexPath) as? FeaturedTableViewCell else {
            return UITableViewCell()
        }
        let featuredModel = model[indexPath.row]
        cell.configure(with: featuredModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedModel = model[indexPath.row]
        
        DispatchQueue.main.async { [weak self] in
            let detailVC = DetailsViewController()
            detailVC.configure(with: selectedModel)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension FeaturedViewController: FeaturedModel {
    func featuredModel(_ model: [Article]) {
        self.model = model
        reloadTableView()
    }
}

extension FeaturedViewController: FeaturedHeaderDelegate {
    func didSelectItem(_ model: Article) {
        DispatchQueue.main.async {
            let detailsVC = DetailsViewController()
            detailsVC.configure(with: model)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
