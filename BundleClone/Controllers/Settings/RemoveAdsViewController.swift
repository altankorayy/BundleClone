//
//  RemoveAdsViewController.swift
//  BundleClone
//
//  Created by Altan on 17.12.2023.
//

import UIKit

class RemoveAdsViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let firstWord = "Welcome"
        let secondWord = "to"
        let attributedString = NSMutableAttributedString(string: "\(firstWord) \(secondWord)")
        let firstWordRange = NSRange(location: 0, length: firstWord.count)
        let firstWordColor = UIColor.red
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: firstWordColor, range: firstWordRange)
        label.attributedText = attributedString
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let premiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bundle Premium"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let premiumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "premiumIllustration")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let addfreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AD - FREE NEWS FEED"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hide the native ads that show up in your news feed."
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = "Click for details."
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        view.addSubviews(welcomeLabel, premiumLabel, premiumImage, addfreeLabel, descriptionLabel, detailsButton)
        
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc
    private func didTapDetailsButton() {
        let alert = UIAlertController(title: "Information", message: "Native ads that show up in your news feed are hidden with Bundle Premium. The ads publishers display are not under our control however and cannot be hidden.", preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "Done", style: .default)
        alert.addAction(doneButton)
        
        if traitCollection.userInterfaceStyle == .dark {
            alert.overrideUserInterfaceStyle = .light
        } else {
            alert.overrideUserInterfaceStyle = .dark
        }
        
        present(alert, animated: true)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            premiumLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            premiumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            premiumImage.topAnchor.constraint(equalTo: premiumLabel.bottomAnchor, constant: 10),
            premiumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            premiumImage.widthAnchor.constraint(equalToConstant: 250),
            premiumImage.heightAnchor.constraint(equalToConstant: 250),
            
            addfreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addfreeLabel.topAnchor.constraint(equalTo: premiumImage.bottomAnchor, constant: 10),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: addfreeLabel.bottomAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            detailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
        ])
    }

}
