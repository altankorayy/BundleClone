//
//  SettingsViewController.swift
//  BundleClone
//
//  Created by Altan on 9.12.2023.
//

import UIKit
import StoreKit
import CoreData

class SettingsViewController: UIViewController {
    
    private let appSettingsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = "APPLICATION SETTINGS"
        return label
    }()
    
    private let darkModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.text = "Dark Mode"
        return label
    }()
    
    private let darkModeSwitch: UISwitch =  {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
    }()
    
    private let premiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = "BUNDLE PREMIUM"
        return label
    }()
    
    private let removeAdsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remove Ads", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()
    
    private let shareTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = "APPLICATION SETTINGS"
        return label
    }()
    
    private let rateAppButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Rate App", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        view.addSubviews(appSettingsTitle, darkModeLabel, darkModeSwitch, premiumLabel, removeAdsButton, shareTitle, rateAppButton)
        
        darkModeSwitch.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
        removeAdsButton.addTarget(self, action: #selector(didTapRemoveAds), for: .touchUpInside)
        rateAppButton.addTarget(self, action: #selector(didTapRateApp), for: .touchUpInside)
        
        configureDarkModeSwitch()
        
        configureConstraints()
    }
    
    private func configureDarkModeSwitch() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
    }
    
    @objc
    private func didTapSwitch(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let appDelegate = windowScene?.windows.first
            
            if sender.isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
            } else {
                appDelegate?.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    @objc
    private func didTapRemoveAds() {
        print("Ads Removed")
    }
    
    @objc
    private func didTapRateApp() {
        Task { @MainActor [weak self] in
            if let windowScene = self?.view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            appSettingsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            appSettingsTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            darkModeLabel.topAnchor.constraint(equalTo: appSettingsTitle.bottomAnchor, constant: 35),
            darkModeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            darkModeSwitch.topAnchor.constraint(equalTo: appSettingsTitle.bottomAnchor, constant: 30),
            darkModeSwitch.leftAnchor.constraint(equalTo: darkModeLabel.rightAnchor, constant: 25),
            
            premiumLabel.topAnchor.constraint(equalTo: darkModeLabel.bottomAnchor, constant: 70),
            premiumLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            removeAdsButton.topAnchor.constraint(equalTo: premiumLabel.bottomAnchor, constant: 35),
            removeAdsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            shareTitle.topAnchor.constraint(equalTo: removeAdsButton.bottomAnchor, constant: 70),
            shareTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            rateAppButton.topAnchor.constraint(equalTo: shareTitle.bottomAnchor, constant: 35),
            rateAppButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
        ])
    }
    
}
