//
//  MenuHaderView.swift
//  BundleClone
//
//  Created by Altan on 27.11.2023.
//

import UIKit

class MenuHaderView: UIView {
    
    public let bundleLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "bundleLogo")
        return imageView
    }()
    
    public let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Bundle User"
        return label
    }()
    
    private let settingsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Settings"
        configuration.image = UIImage(systemName: "gearshape.fill")
        configuration.imagePadding = 10
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .secondaryLabel
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 9/255, green: 19/255, blue: 26/255, alpha: 1)
        addSubviews(bundleLogo, usernameLabel, settingsButton)
                
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func hiddenState(with state: Bool) {
        if state {
            bundleLogo.isHidden = true
            usernameLabel.isHidden = true
            settingsButton.isHidden = true
        } else {
            bundleLogo.isHidden = false
            usernameLabel.isHidden = false
            settingsButton.isHidden = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            bundleLogo.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            bundleLogo.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            bundleLogo.heightAnchor.constraint(equalToConstant: 40),
            bundleLogo.widthAnchor.constraint(equalToConstant: 40),
            
            usernameLabel.centerYAnchor.constraint(equalTo: bundleLogo.centerYAnchor),
            usernameLabel.leftAnchor.constraint(equalTo: bundleLogo.rightAnchor, constant: 15),
            
            settingsButton.topAnchor.constraint(equalTo: bundleLogo.bottomAnchor, constant: 40),
            settingsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
        ])
    }
    
}
