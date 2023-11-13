//
//  ContentStoreViewController.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class ContentStoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "CONTENT STORE"
        configureInterfaceStyle()
    }

    private func configureInterfaceStyle() {
        if UIScreen.darkMode {
            view.backgroundColor = UIColor.bundleColor
        } else {
            view.backgroundColor = .white
        }
    }

}
