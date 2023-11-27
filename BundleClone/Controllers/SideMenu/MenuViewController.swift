//
//  MenuViewController.swift
//  BundleClone
//
//  Created by Altan on 27.11.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    enum MenuOptions: String, CaseIterable {
        case all = "ALL"
        case news = "NEWS"
        case tech = "TECHNOLOGY"
        case gaming = "GAMING & GEEK"
        case politics = "POLITICS"
        case finance = "BUSINESS & FINANCE"
        case lifestyle = "LIFESTYLE"
        case science = "SCIENCE"
        case sports = "SPORTS"
        case cinema = "CINEMA"
        case arts = "ARTS & CULTURE"
    }
    
    enum Sections: Int {
        case all = 0
        case news = 1
        case tech = 2
        case gaming = 3
        case politics = 4
        case finance = 5
        case lifestyle = 6
        case science = 7
        case sports = 8
        case cinema = 9
        case arts = 10
    }
    
    let sectionTitles = [" "," "," "," "," "," "," "," "," "," "," "]
    
    private let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 9/255, green: 19/255, blue: 26/255, alpha: 1)

        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        view.addSubview(menuTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.all.rawValue:
            cell.configure(headers: MenuOptions.all.rawValue)
        case Sections.sports.rawValue:
            cell.configure(headers: MenuOptions.sports.rawValue)
        case Sections.gaming.rawValue:
            cell.configure(headers: MenuOptions.gaming.rawValue)
        case Sections.tech.rawValue:
            cell.configure(headers: MenuOptions.tech.rawValue)
        case Sections.politics.rawValue:
            cell.configure(headers: MenuOptions.politics.rawValue)
        case Sections.finance.rawValue:
            cell.configure(headers: MenuOptions.finance.rawValue)
        case Sections.lifestyle.rawValue:
            cell.configure(headers: MenuOptions.lifestyle.rawValue)
        case Sections.science.rawValue:
            cell.configure(headers: MenuOptions.science.rawValue)
        case Sections.news.rawValue:
            cell.configure(headers: MenuOptions.news.rawValue)
        case Sections.cinema.rawValue:
            cell.configure(headers: MenuOptions.cinema.rawValue)
        case Sections.arts.rawValue:
            cell.configure(headers: MenuOptions.arts.rawValue)
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}