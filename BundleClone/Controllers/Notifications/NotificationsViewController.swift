//
//  NotificationsViewController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    private var tableView: UITableView?
    
    private let viewModel = NotificationsViewModel()
    
    private var notificationsModel: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "NOTIFICATIONS"
        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        
        let tableView = configureTableView()
        self.tableView = tableView
        
        view.addSubview(tableView)
        
        viewModel.fetchNotifications()
        viewModel.delegate = self
        
        configureConstraints()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    }
    
    public func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
            UIView.animate(withDuration: 0.3) {
                self?.tableView?.alpha = 1
            }
        }
    }
    
    private func configureTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NotificationsTableViewCell.self, forCellReuseIdentifier: NotificationsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.alpha = 0
        return tableView
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

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }
        let model = notificationsModel[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedModel = notificationsModel[indexPath.row]
        
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

extension NotificationsViewController: NotificationsModelPass {
    func notificationsModel(_ model: [Article]) {
        self.notificationsModel = model
        reloadTableView()
    }
}
