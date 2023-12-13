//
//  MenuHaderView.swift
//  BundleClone
//
//  Created by Altan on 27.11.2023.
//

import UIKit

protocol DidTapSettingButtonDelegate: AnyObject {
    func didTapSettingsButton()
}

class MenuHeaderView: UIView {
    
    public let bundleLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = UIDevice.isiPhone ? 20 : 30
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "bundleLogo")
        return imageView
    }()
    
    public let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: UIDevice.isiPhone ? 15 : 19, weight: .regular)
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
    
    weak var delegate: DidTapSettingButtonDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        addSubviews(bundleLogo, usernameLabel, settingsButton)
        
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
                
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func didTapSettingsButton() {
        self.delegate?.didTapSettingsButton()
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
            bundleLogo.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 40 : 60),
            bundleLogo.widthAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 40 : 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: bundleLogo.centerYAnchor),
            usernameLabel.leftAnchor.constraint(equalTo: bundleLogo.rightAnchor, constant: 15),
            
            settingsButton.topAnchor.constraint(equalTo: bundleLogo.bottomAnchor, constant: 40),
            settingsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
        ])
    }
    
}
