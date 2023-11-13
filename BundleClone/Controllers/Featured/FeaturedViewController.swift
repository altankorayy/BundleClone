//
//  FeaturedViewController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    private var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "FEATURED"
        configureInterfaceStyle()
        
        let tableView = createTableView()
        self.tableView = tableView
        view.addSubview(tableView)
        
        configureConstraints()
        
        setHeaderView()
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeaturedTableViewCell.self, forCellReuseIdentifier: FeaturedTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        return tableView
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
        header.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
        
        self.tableView?.tableHeaderView = header
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedTableViewCell.identifier, for: indexPath) as? FeaturedTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
